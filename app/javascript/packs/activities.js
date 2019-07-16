import Vue from 'vue/dist/vue.esm'
import _ from 'lodash';

import ActivityCard from '../components/activity_card'
import ActivityList from '../components/activity_list'
import ActivitiesDashboard from '../components/activities_dashboard'
import DashboardHeader from '../components/dashboard_header'

export const eventBus = new Vue();

Vue.component('activity_card', ActivityCard);
Vue.component('activity_list', ActivityList);
Vue.component('activities_dashboard', ActivitiesDashboard);
Vue.component('dashboard_header', DashboardHeader);

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#dashboard'
  })
});
