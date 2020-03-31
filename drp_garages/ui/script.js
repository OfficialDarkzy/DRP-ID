const GarageUIApp = new Vue({
  el: "#ISRP_Garage_UI",

  data: {
    showGarageMenu: false,
    showImpoundMenu: false,
    vehicles: [],
    garageslot: [],
    impoundslot: []
  },

  methods: {
    ///////////////////////////////////////////////////////////////////////////
    // GARAGES
    ///////////////////////////////////////////////////////////////////////////
    OpenGarage(vehicles, garageslot) {
      this.vehicles = vehicles;
      this.garageslot = garageslot;
      this.showGarageMenu = true;
    },

    OpenImpound(vehicles, impoundslot) {
      this.vehicles = vehicles;
      this.impoundslot = impoundslot;
      this.showImpoundMenu = true;
    },

    CloseGarage() {
      this.showGarageMenu = false;
      this.showImpoundMenu = false;
      axios
        .post("http://drp_garages/close_garage", {})
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    },

    StoreVehicle() {
      this.showGarageMenu = false;
      axios
        .post("http://drp_garages/store_vehicle", {})
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    },

    SelectThisVehicle(selectedIndex, type) {
      console.log(`VEHICLE ID: ${this.vehicles[selectedIndex].id}`);
      var vehicle_info = this.vehicles[selectedIndex].id;
      axios
        .post("http://drp_garages/select_vehicle", {
          selectedVehicle: vehicle_info,
          type: type
        })
        .then(response => {
          console.log(response);
          this.CloseGarage();
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
});

// Listener from Lua CL
document.onreadystatechange = () => {
  if (document.readyState == "complete") {
    window.addEventListener("message", event => {
      if (event.data.type == "open_garage_menu") {
        GarageUIApp.OpenGarage(event.data.vehicles, event.data.garageslot);
      } else if (event.data.type == "open_impound_menu") {
        GarageUIApp.OpenImpound(event.data.vehicles, event.data.impoundslot);
      } else if (event.data.type == "close_menu") {
        GarageUIApp.CloseGarage();
      }
    });
  }
};