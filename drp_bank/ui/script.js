///////////////////////////////////////////////////////////////////////////
// Vue app handling ATM menu instance
///////////////////////////////////////////////////////////////////////////
const ATMMenu = new Vue({
  el: "#ATM_Menu",

  data: {
    // Important Data
    ResourceName: "drp_bank",

    // Booleans
    showATMMenu: false,
    showBankMenu: false,
    loading: false,

    // Rules
    inputRules: [
      v => !!v || "Input invalid",
      v => (!!v && RegExp("^(0|[1-9][0-9]*)$").test(v)) || "Not a number",
      v => (!!v && v >= 1) || "Input must be greater than 0",
      v => (!!v && v[0] != 0) || "Input must not begin with a 0"
    ],

    atmWithDrawInputRules: [
      v => !!v || "Input invalid",
      v => (!!v && RegExp("^(0|[1-9][0-9]*)$").test(v)) || "Not a number",
      v => (!!v && v >= 1) || "Input must be greater than 0",
      v => (!!v && v[0] != 0) || "Input must not begin with a 0",
      v => (!!v && v <= 250) || "Input must not be greater than 250",
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
    OpenATMMenu(name, balance, cash) {
      this.showATMMenu = true;
      this.character_name = name;
      this.account = balance;
      this.cash = cash;
    },

    OpenBankMenu(name, balance, cash) {
      this.showBankMenu = true;
      this.character_name = name;
      this.account = balance;
      this.cash = cash;
    },

    CloseATMMenu() {
      axios
        .post(`http://${this.ResourceName}/closeatm`, {})
        .then(response => {
          console.log("closing menu!");
          this.showATMMenu = false;
          this.$refs.depositForm.reset();
          this.$refs.withdrawForm.reset();
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    },

    CloseBankMenu() {
      axios
        .post(`http://${this.ResourceName}/closebank`, {})
        .then(response => {
          console.log("closing menu!");
          this.showBankMenu = false;
          this.$refs.depositForm.reset();
          
          this.$refs.withdrawForm.reset();
          this.$refs.withdrawBankForm.reset();
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
          .post(`http://${this.ResourceName}/deposit`, {
            amount: this.depositAmount
          })
          .then(response => {
            console.log(response);
          })
          .catch(error => {
            console.log(error);
          });
        this.$refs.depositForm.reset();
        this.$refs.withdrawBankForm.reset();
      }
    },

    WithdrawMoney() {
      if (this.withdrawFormValid) {
        this.loading = true;
        axios
          .post(`http://${this.ResourceName}/withdraw`, {
            amount: this.withdrawAmount
          })
          .then(response => {
            console.log(response);
          })
          .catch(error => {
            console.log(error);
          });
        this.$refs.withdrawForm.reset();
        this.$refs.withdrawBankForm.reset();
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
      this.$refs.withdrawBankForm.reset();
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
        ATMMenu.OpenATMMenu(event.data.name, event.data.balance, event.data.cash);
      } else if (event.data.type == "open_bank_menu") {
        ATMMenu.OpenBankMenu(event.data.name, event.data.balance, event.data.cash);
      } else if (event.data.type == "update_menus") {
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
