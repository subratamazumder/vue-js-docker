<template>
  <Registration msg="Welcome to ePrescription Demo" version="4.0" firstName="" lastName=""/>
</template>

<script>
import Registration from './components/Registration.vue'

export default {
  name: 'App',
  components: {
    Registration
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
