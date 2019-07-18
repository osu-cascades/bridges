import Vue from 'vue/dist/vue.esm'
import _ from 'lodash';

import ModelCard from '../components/model_card'
import ModelList from '../components/model_list'
import ModelsDashboard from '../components/models_dashboard'
import DashboardHeader from '../components/dashboard_header'

export const eventBus = new Vue();

Vue.component('model_card', ModelCard);
Vue.component('model_list', ModelList);
Vue.component('models_dashboard', ModelsDashboard);
Vue.component('dashboard_header', DashboardHeader);

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#dashboard'
  })
});
