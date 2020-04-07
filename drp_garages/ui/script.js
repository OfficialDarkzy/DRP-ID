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

const VehicleShopUI = new Vue({
  el: "#DRP_vehicleshop_UI",

  data: {
    showShopMenu: false,
    showBuyQuestion: false,

    // Arrays
    currentPage: "Compacts",
    pages: ["Compacts", "Coupes", "Sport", "Sport Classic", "Super", "Muscle", "Off Road", "Suvs", "Vans", "Sedans", "Exclusives","Motorcycles"],
    Colors: ["Red", "Blue", "Black", "Yellow", "Pink", "White", "Green"],
    
    vehicles: [],
    vehicledata: [],
    SelectedColor: ""
  },

  methods: {

    OpenShopMenu(vehicles) {
      this.vehicles = vehicles;
      this.showShopMenu = true;
    },

    CloseShopMenu() {
      this.showBuyQuestion = false;
      this.showShopMenu = false;
      axios.post("http://drp_garages/close_shop", {})
      .then(response => {
        console.log(response);
      })
      .catch(error => {
        console.log(error);
      });
    },

    ShowQuestion(vehicle) {
      this.showBuyQuestion = true;
      this.vehicledata = vehicle;
    },

    ChangePage(page) {
      this.currentPage = page;
    },

    BuyThisVehicle(selectedVehicle, price, color) {
      axios.post("http://drp_garages/selected_vehicle", {
        selectedVehicle: selectedVehicle,
        price: price,
        color: color
      })
      .then(response => {
        console.log(response);
        this.CloseShopMenu();
      })
      .catch(error => {
        console.log(error);
      });
    },

    ResetButtons(both) {
      if (both) {
        this.SelectedColor = "",
        this.currentPage = "Compacts"
      } else {
        this.SelectedColor = ""
      }
    },

    numberformat(value) {
      let val = (value/1).toFixed(0).split('.')
      return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")
    }

  },

  computed: {
  	isDisabled: function(){
    	return !this.SelectedColor;
    },
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
      } else if (event.data.type == "open_shop_menu") {
        VehicleShopUI.OpenShopMenu(event.data.vehicles);
      }
    });
  }
};