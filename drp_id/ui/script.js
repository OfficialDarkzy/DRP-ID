const DRP_Characters = new Vue({
  el: "#DRP_Characters",

  data: {
    // Shared
    ResourceName: "drp_id",
    showCharacterSpawnMenu: false,
    showCharacterSelector: false,
    showCharacterCreator: false,
    showCharacterDelete: false,
    showDisconnectQuestion: false,

    // Character Selector
    characters: [],

    // Character Creator
    genders: ["Male", "Female"],

    selectedFirstname: "",
    selectedLastname: "",
    selectedGender: "",
    selectedAge: "",
    selectedDeleteCharacter: "",

    spawn: "",
    ped: "",

    nameRules: [
      v => !!v || "Name required",
      v => (!!v && v.length <= 15) || "Name must be 15 characters or less",
      v => (!!v && RegExp("^[a-zA-Z]+$").test(v)) || "Invalid Characters",
      v => (!!v && v.length >= 4) || "Name must be 4 - 15 characters"
    ],

    genderRules: [
      v => !!v || "Gender Required, you can't be an Attack Helicopter... sorry!"
    ],

    dobRules: [
      v => (!!v && v >= 18) || "You must be 18+ to create a character",
      v =>
        (!!v && v <= 100) || "You must be less than 100 to create a character"
    ]
  },

  methods: {
    // START OF MAIN MENU
    OpenCharactersMenu(characters) {
      this.showCharacterSelector = true;
      this.characters = characters;
    },

    OpenSpawnSelectionMenu(ped, spawn) {
      this.showCharacterSpawnMenu = true;
      this.ped = ped;
      this.spawn = spawn;
    },

    CloseCharactersMenu() {
      axios
        .post(`http://${this.ResourceName}/CloseMenu`, {})
        .then(response => {
          this.showCharacterCreator = false;
          this.showCharacterSelector = false;
        })
        .catch(error => {});
    },

    CloseSpawnMenu() {
      axios
        .post(`http://${this.ResourceName}/CloseMenu`, {})
        .then(response => {
          this.showCharacterSpawnMenu = false;
        })
        .catch(error => {});
    },

    ClothingSpawn() {
      axios
        .post(`http://${this.ResourceName}/ClothingSpawn`, {
          ped: this.ped,
          spawn: [71.88147, -1398.833, 29.37616]
        })
        .then(response => {
          this.showCharacterSpawnMenu = false;
        })
        .catch(error => {});
    },

    GarageSpawn() {
      axios
        .post(`http://${this.ResourceName}/GarageSpawn`, {
          ped: this.ped,
          spawn: [279.7169, -345.4529, 44.91983]
        })
        .then(response => {
          this.showCharacterSpawnMenu = false;
        })
        .catch(error => {});
    },

    HospitalSpawn() {
      axios
        .post(`http://${this.ResourceName}/HospitalSpawn`, {
          ped: this.ped,
          spawn: [306.795, -619.6395, 43.44999]
        })
        .then(response => {
          this.showCharacterSpawnMenu = false;
        })
        .catch(error => {});
    },

    TrainSpawn() {
      axios
        .post(`http://${this.ResourceName}/TrainSpawn`, {
          ped: this.ped,
          spawn: [295.5171, -1204.268, 38.90181]
        })
        .then(response => {
          this.showCharacterSpawnMenu = false;
        })
        .catch(error => {});
    },

    PaletoSpawn() {
      axios
        .post(`http://${this.ResourceName}/PaletoSpawn`, {
          ped: this.ped,
          spawn: [-161.9633, 6421.395, 31.91187]
        })
        .then(response => {
          this.showCharacterSpawnMenu = false;
        })
        .catch(error => {});
    },

    SandySpawn() {
      axios
        .post(`http://${this.ResourceName}/SandySpawn`, {
          ped: this.ped,
          spawn: [1141.746, 2663.611, 38.16086]
        })
        .then(response => {
          this.showCharacterSpawnMenu = false;
        })
        .catch(error => {});
    },

    AirportSpawn() {
      axios
        .post(`http://${this.ResourceName}/AirportSpawn`, {
          ped: this.ped,
          spawn: [-211.3702, -1021.899, 30.14071]
        })
        .then(response => {
          this.showCharacterSpawnMenu = false;
        })
        .catch(error => {});
    },

    UpdateCharacters(characters) {
      this.characters = characters;
      if (this.showCharacterCreator == false) {
        this.FormReset();
      }
    },

    CreateCharacter() {
      if (this.$refs.DRPCreatorForm.validate()) {
        axios
          .post(`http://${this.ResourceName}/CreateCharacter`, {
            name: `${FixName(this.selectedFirstname)} ${FixName(
              this.selectedLastname
            )}`,
            age: this.selectedAge,
            gender: this.selectedGender
          })
          .then(response => {
            this.showCharacterCreator = false;
          })
          .catch(error => {});
      }
    },

    SelectCharacter(index) {
      console.log(`CHARACTER ID: ${this.characters[index].id}`);
      this.showCharacterSelector = false;
      var character_info = this.characters[index].id;
      axios
        .post(`http://${this.ResourceName}/SelectYourCharacter`, {
          character_selected: character_info
        })
        .then(response => {})
        .catch(error => {});
    },

    DisconectMe() {
      this.showDisconnectQuestion = false;
      axios
        .post(`http://${this.ResourceName}/DisconnectMe`, {})
        .then(response => {})
        .catch(error => {});
    },

    DeleteCharacter() {
      this.showCharacterDelete = false;
      var chosen_character = this.characters[this.selectedDeleteCharacter].id;
      axios
        .post(`http://${this.ResourceName}/DeleteCharacter`, {
          character_id: chosen_character
        })
        .then(response => {})
        .catch(error => {});
    },

    RequestDeleteCharacter(index) {
      this.selectedDeleteCharacter = index;
      this.showCharacterDelete = true;
    },

    FormReset() {
      this.$refs.DRPCreatorForm.reset();
      this.selectedAge = 0;
    },

    FinishCharacter() {
      if (this.model != "") {
        this.showCharacterModifier = false;
        axios
          .post(`http://${this.ResourceName}/finishcharactercreator`, {
            model: this.model
          })
          .then(response => {
            console.log(response);
          })
          .catch(error => {
            console.log(error);
          });
      }
    }
  }
});

function FixName(name) {
  var newName = "";
  for (var a = 0; a < name.length; a++) {
    if (a == 0) {
      newName = name[a].toUpperCase();
    } else {
      var concat = newName + name[a].toLowerCase();
      newName = concat;
    }
  }
  return newName;
}

// Listener from Lua CL
document.onreadystatechange = () => {
  if (document.readyState == "complete") {
    window.addEventListener("message", event => {
      ///////////////////////////////////////////////////////////////////////////
      // Character Main Menu
      ///////////////////////////////////////////////////////////////////////////

      if (event.data.type == "open_character_menu") {
        DRP_Characters.OpenCharactersMenu(event.data.characters);
      } else if (event.data.type == "update_character_menu") {
        DRP_Characters.UpdateCharacters(event.data.characters);
      } else if (event.data.type == "open_spawnselection_menu") {
        DRP_Characters.OpenSpawnSelectionMenu(event.data.ped, event.data.spawn);
      }
    });
  }
};
