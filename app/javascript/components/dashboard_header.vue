<template>
  <div class="dashboard-header">
    <h1 class="text-center">Bridging Out-of-School Time</h1>
    <p class="text-center">A catalog of after school, weekend, and summer activities for children and young adults in Central Oregon.</p>
    <div class="jumbotron center">
      <form class="form-inline search">
        <input class="col-md-6 form-control form-control-lg" type="text" placeholder="Search... After school? Age 8? Sports?" v-model="search" v-on:keydown.enter.prevent></input>
      </form>
      <div class="section tags">
        <button v-for="tag in tagsData" v-on:click="select(tag)" v-bind:class="active(tag)" class="tag badge badge-pill mr-1">{{ tag.name }}</button>
      </div>
      <div class="mt-4 text-center">
        <button v-on:click="clearSearch" class="btn btn-outline-secondary btn-sm">Clear Search</button>
      </div>
    </div>
  </div>
</template>

<script>
import { eventBus } from '../packs/models';
import axios from 'axios';

export default {
  props: {
    tags: {
      type: Array,
      required: true
    },
    model: {
      type: String,
      required: true
    }
  },
  data: function () {
    return {
      search: '',
      selected_tags: [],
      tagsData: this.tags
    }
  },
  methods: {
    select: async function (tag) {
      const indexOfTag = this.selected_tags.indexOf(tag.name);
      indexOfTag === -1 ?
        this.selected_tags.push(tag.name) :
        this.selected_tags.splice(indexOfTag, 1);
      const { data } = await axios.get(`/${this.model}.json`, { params: { tags: this.selected_tags, search: this.search }, headers: { 'Content-Type': 'application/json' } });
      this[`${this.model}Data`] = data[this.model];
      eventBus.$emit(`active_${this.model}_updated`, this[`${this.model}Data`]);
    },
    clearSearch: async function () {
      const { data } = await axios.get(`/${this.model}.json`, { headers: { 'Content-Type': 'application/json' } });
      this.search = '';
      this[`${this.model}Data`] = data[this.model];
      this.selected_tags = [];
      eventBus.$emit(`active_${this.model}_updated`, this[`${this.model}Data`]);
    },
    active: function (tag) {
      return this.selected_tags.includes(tag.name)  ? 'active' : '';
    }
  },
  watch: {
    search: _.debounce(async function (val) {
      const { data } = await axios.get(`/${this.model}.json`, { params: { tags: this.selected_tags, search: val }, headers: { 'Content-Type': 'application/json' } });
      this[`${this.model}Data`] = data[this.model];
      eventBus.$emit(`active_${this.model}_updated`, this[`${this.model}Data`]);
    }, 1000)
  }
}
</script>
