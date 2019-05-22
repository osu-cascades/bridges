import Vue from 'vue/dist/vue.esm'
import axios from 'axios';
import _ from 'lodash';

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('dashboard');
  const app = new Vue({
    el: '#dashboard',
    data: {
      search: '',
      selected_tags: [],
      tags: JSON.parse(element.getAttribute('tags')),
      activities: JSON.parse(element.getAttribute('activities'))
    },
    methods: {
      select: async function (tag) {
        const indexOfTag = this.selected_tags.indexOf(tag.name);
        indexOfTag === -1 ?
          this.selected_tags.push(tag.name) :
          this.selected_tags.splice(indexOfTag, 1);
        const { data } = await axios.get('/activities.json', { params: { tags: this.selected_tags }, headers: { 'Content-Type': 'application/json' } });
        this.activities = data;
      },
      clearTags: async function () {
        const { data } = await axios.get('/activities.json', { headers: { 'Content-Type': 'application/json' } });
        this.activities = data;
        this.selected_tags = [];
      },
      active: function (tag) {
        return this.selected_tags.includes(tag.name)  ? 'active' : '';
      }
    },
    watch: {
      search: _.debounce(async function (val) {
        const { data } = await axios.get('/activities.json', { params: { tags: this.selected_tags, search: val }, headers: { 'Content-Type': 'application/json' } });
        this.activities = data;
      }, 1000)
    }
  });
});
