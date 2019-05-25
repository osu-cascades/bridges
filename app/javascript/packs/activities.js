import Vue from 'vue/dist/vue.esm'
import _ from 'lodash';

import ActivityCard from '../components/activity_card'
import ActivitiesDashboard from '../components/activities_dashboard.vue'

export const eventBus = new Vue();

Vue.component('activity_card', ActivityCard);
Vue.component('activities_dashboard', ActivitiesDashboard);

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#dashboard'
  })
});