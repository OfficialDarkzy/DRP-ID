///////////////////////////////////////////////////////////////////////////
// Vue app handling ATM menu instance
///////////////////////////////////////////////////////////////////////////
const ATMMenu = new Vue({
  el: "#ATM_Menu",

  data: {
    // Important Data
    ResourceName: "drp_bank",

    // Booleans
    showMenu: false,
    loading: false,

    // Rules
    inputRules: [
      v => !!v || "Input invalid",
      v => (!!v && RegExp("^(0|[1-9][0-9]*)$").test(v)) || "Not a number",
      v => (!!v && v >= 1) || "Input must be greater than 0",
      v => (!!v && v[0] != 0) || "Input must not begin with a 0"
    ],

    // Character Information
    character_name: "",
    account: 0,
    cash: 0,

    // Inputs
    depositFormValid: false,
    withdrawFormValid: false,
    depositAmount: 0,
    withdrawAmount: 0
  },

  methods: {
    OpenMenu(name, balance, cash) {
      this.showMenu = true;
      this.character_name = name;
      this.account = balance;
      this.cash = cash;
    },

    CloseMenu() {
      axios
        .post(`http://${this.ResourceName}/closeatm`, {})
        .then(response => {
          console.log("closing menu!");
          this.showMenu = false;
          this.$refs.depositForm.reset();
          this.$refs.withdrawForm.reset();
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    },

    DepositMoney() {
      if (this.depositFormValid) {
        this.loading = true;
        axios
          .post(`http://${this.ResourceName}/depositatm`, {
            amount: this.depositAmount
          })
          .then(response => {
            console.log(response);
          })
          .catch(error => {
            console.log(error);
          });
        this.$refs.depositForm.reset();
      }
    },

    WithdrawMoney() {
      if (this.withdrawFormValid) {
        this.loading = true;
        axios
          .post(`http://${this.ResourceName}/withdrawatm`, {
            amount: this.withdrawAmount
          })
          .then(response => {
            console.log(response);
          })
          .catch(error => {
            console.log(error);
          });
        this.$refs.withdrawForm.reset();
      }
    },

    Quick250() {
      this.loading = true;
      axios
        .post(`http://${this.ResourceName}/quick250`, {})
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    },

    DepositAll() {
      this.loading = true;
      axios
        .post(`http://${this.ResourceName}/depositall`, {
          cashTotal: this.cash
        })
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    },

    UpdateMenu(status, message, balance, cash) {
      if (status) {
        this.account = balance;
        this.cash = cash;
      }
      this.$refs.depositForm.reset();
      this.$refs.withdrawForm.reset();
      this.loading = false;
    }
  }
});

// Listener from Lua CL
document.onreadystatechange = () => {
  if (document.readyState == "complete") {
    window.addEventListener("message", event => {
      ///////////////////////////////////////////////////////////////////////////
      // Character Main Menu
      ///////////////////////////////////////////////////////////////////////////

      if (event.data.type == "open_atm_menu") {
        ATMMenu.OpenMenu(event.data.name, event.data.balance, event.data.cash);
      } else if (event.data.type == "update_atm_menu") {
        ATMMenu.UpdateMenu(
          event.data.status,
          event.data.message,
          event.data.balance,
          event.data.cash
        );
      }
    });
  }
};
