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
      <table class="center">
        <tr>
          <th>API Response Code</th>
          <th>Registration ID</th>
          <th>Kubernetes POD</th>
          <th>Registration API Version</th>
        </tr>
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
        // mode: "no-cors",
        // cache: "no-cache",
        headers: {
          "Content-Type": "application/json",
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
th,
td {
  border: 1px solid black;
}
.center {
  margin-left: auto;
  margin-right: auto;
  align-content: center;
}
</style>
