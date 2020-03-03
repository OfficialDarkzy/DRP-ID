const DRP_Jobcore = new Vue({
  el: "#DRP_Jobcore",

  data: {
    showMenu: false,
    currentMenu: "main"
  },

  methods: {
    ChangeMenu(menu) {
      this.currentMenu = menu;
    },

    OpenMenu() {
      this.showMenu = true;
    },

    CloseMenu() {
      this.showMenu = false;
      this.currentMenu = "main";
      axios
        .post("http://drp_jobcore/close_menu", {})
        .then(response => {})
        .catch(error => {});
    },

    ///////////////////////////////////////////////////////////////////////////
    // ACTIONS
    ///////////////////////////////////////////////////////////////////////////
    Blindfold() {
      DRP_Jobcore.CloseMenu();
      axios
        .post("http://drp_jobcore/blindfold", {})
        .then(response => {})
        .catch(error => {});
    },

    Ziptie() {
      DRP_Jobcore.CloseMenu();
      axios
        .post("http://drp_jobcore/ziptie", {})
        .then(response => {})
        .catch(error => {});
    },

    Drag() {
      DRP_Jobcore.CloseMenu();
      axios
        .post("http://drp_jobcore/drag", {})
        .then(response => {})
        .catch(error => {});
    },

    PutInVehicle() {
      DRP_Jobcore.CloseMenu();
      axios
        .post("http://drp_jobcore/putinvehicle", {})
        .then(response => {})
        .catch(error => {});
    },

    UnseatFromVehicle() {
      DRP_Jobcore.CloseMenu();
      axios
        .post("http://drp_jobcore/unseatfromvehicle", {})
        .then(response => {})
        .catch(error => {});
    },

    ShowBadge() {
      DRP_Jobcore.CloseMenu();
      axios
        .post("http://drp_jobcore/showbadge", {})
        .then(response => {})
        .catch(error => {});
    },

    Handcuff() {
      DRP_Jobcore.CloseMenu();
      axios
        .post("http://drp_jobcore/handcuff", {})
        .then(response => {})
        .catch(error => {});
    },

    Search() {
      DRP_Jobcore.CloseMenu();
      axios
        .post("http://drp_jobcore/search", {})
        .then(response => {})
        .catch(error => {});
    },

    Revive() {
      DRP_Jobcore.CloseMenu();
      axios
        .post("http://drp_jobcore/revive", {})
        .then(response => {})
        .catch(error => {});
    },

    Heal() {
      DRP_Jobcore.CloseMenu();
      axios
        .post("http://drp_jobcore/heal", {})
        .then(response => {})
        .catch(error => {});
    },

    Fine() {
      DRP_Jobcore.CloseMenu();
      axios
        .post("http://drp_jobcore/fine", {})
        .then(response => {})
        .catch(error => {});
    }
  }
});

document.onreadystatechange = () => {
  if (document.readyState === "complete") {
    window.addEventListener("message", event => {
      if (event.data.type == "open_menu") {
        DRP_Jobcore.OpenMenu();
      }
    });
  }
};
