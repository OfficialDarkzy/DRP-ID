const GarageUIApp = new Vue({
  el: "#ISRP_Garage_UI",

  data: {
    showGarageMenu: false,
    vehicles: []
  },

  methods: {
    ///////////////////////////////////////////////////////////////////////////
    // GARAGES
    ///////////////////////////////////////////////////////////////////////////
    OpenGarage(vehicles) {
      this.vehicles = vehicles;
      this.showGarageMenu = true;
    },

    CloseGarage() {
      this.showGarageMenu = false;
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

    SelectThisVehicle(selectedIndex) {
      console.log(`VEHICLE ID: ${this.vehicles[selectedIndex].id}`);
      var vehicle_info = this.vehicles[selectedIndex].id;
      axios
        .post("http://drp_garages/select_vehicle", {
          selectedVehicle: vehicle_info
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
        GarageUIApp.OpenGarage(event.data.vehicles);
      }
    });
  }
};
