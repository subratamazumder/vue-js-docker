<template>
  <div class="hello">
    <h1>{{ msg }} {{ version }}</h1>
    <br />

    <input v-model="firstName" placeholder="Type First name" />
    <br />
    <br />
    <input v-model="lastName" placeholder="Type Last name" />
    <br />
    <br />
    <button @click="onClick()">Register</button>
    <br />
    <br />
    <h4>{{ validationMsg }}</h4>
    <br />
    <div id="responseTable" style="display: none">
      <table class="styled-table">
        <thead>
        <tr>
          <th>API Response Code</th>
          <th>Registration ID</th>
          <th>Kubernetes POD</th>
          <th>API Version</th>
        </tr>
        </thead>
        <tr>
          <td>{{ statusCode }}</td>
          <td>{{ registrationId }}</td>
          <td>{{ processingNode }}</td>
          <td>{{ serviceVersion }}</td>
        </tr>
      </table>
    </div>
    <br />
    <div class="foter">
      <h2>Powered by <img alt="Vue logo" src="../assets/logo.png" /></h2>
    </div>
  </div>
</template>

<script>
export default {
  name: "Registration",
  props: {
    msg: String,
    version: String,
  },
  data() {
    return {
      firstName: "",
      lastName: "",
      registrationId: "",
      processingNode: "",
      serviceVersion: "",
      statusCode: "",
      validationMsg: "",
    };
  },
  methods: {
    async onClick() {
      // console.log(event)
      // event.preventDefault()
      console.log("in method onSubmit");
      var x = document.getElementById("responseTable");
      this.registrationId = "";
      this.processingNode = "";
      this.serviceVersion = "";
      this.statusCode = "";

      if (!this.firstName || !this.lastName) {
        console.log("validation failed");
        this.validationMsg = "Both fileds are mandatory!";
        x.style.display = "none";
        return;
      }
      //remove validation msg
      this.validationMsg = "";
      var requestPayload = {
        firstName: this.firstName,
        lastName: this.lastName,
      };
      console.log("Request payload -", requestPayload);

      var url =
        "http://acf863c48dd274523ac1354cbca27434-1448754667.eu-west-2.elb.amazonaws.com/ep-registration-service/registrations";
      const res = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(requestPayload),
      });
      if (res.ok) {
        if (x.style.display === "none") {
          x.style.display = "block";
        }
        const responsePayload = await res.json();
        this.registrationId = responsePayload.registrationId;
        this.processingNode = responsePayload.processingNode;
        this.serviceVersion = responsePayload.serviceVersion;
        this.statusCode = res.status;
        console.log("API Response Status-", res.status);
        console.log("API Response Payload-", responsePayload);
      } else {
        console.log("Response failed", res.ok);
      }
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h4 {
  color: red;
}
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
img {
  display: inline-block;
  width: 10%;
  height: 10%;
}
.foter {
  display: inline-block;
  bottom: 0;
  margin-left: auto;
  margin-right: auto;
}
/* th,
td {
  border: 1px solid black;
} */
.styled-table {
    border-collapse: collapse;
    margin: 25px 0;
    font-size: 0.9em;
    font-family: sans-serif;
    min-width: 400px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
    margin-left: auto;
  margin-right: auto;
  align-content: center;
}
.styled-table thead tr {
    background-color: #77aca2;
    color: #ffffff;
    text-align: left;
}
.styled-table th,
.styled-table td {
    padding: 12px 15px;
}
.styled-table tbody tr {
    border-bottom: 1px solid #dddddd;
}

.styled-table tbody tr:nth-of-type(even) {
    background-color: #f3f3f3;
}

.styled-table tbody tr:last-of-type {
    border-bottom: 2px solid #009879;
}
.center {
  margin-left: auto;
  margin-right: auto;
  align-content: center;
}
button {
  text-align: center;
  margin: 5px;
  font-size: 20px ;
  background-color: #77aca2;
  border: 1px solid #d5d9d9;
  border-radius: 8px;
  box-shadow: rgba(213, 217, 217, .5) 0 2px 5px 0;
  box-sizing: border-box;
  color: #ffffff;
  cursor: pointer;
  display: inline-block;
  font-family: sans-serif;
  font-size: 20px;
  line-height: 35px;
  padding: 0 10px 0 11px;
  position: relative;
  text-align: center;
  text-decoration: none;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  vertical-align: middle;
  width: 100px;
}
</style>
