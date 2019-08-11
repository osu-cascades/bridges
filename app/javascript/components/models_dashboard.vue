<template>
  <div class="models-dashboard">
    <DashboardHeader :model="modelPlural" :tags="tagsData"></DashboardHeader>
    <nav class="subnav">
      <a class="btn btn-primary" v-if="admin || modelSingular === 'activity'" v-bind:title="`Add a new ${modelSingular}`" v-bind:href="`/${modelPlural}/new`">Add {{ modelSingular }}</a>
      <button v-on:click="toggleView" title="Toggle view" class="btn btn-primary">View as {{ view === 'card' ? 'list' : 'cards' }}</button>
    </nav>
    <div v-for="state in modelStates">
      <div class="container" v-if="admin && view === 'card'">
        <ModelCard :modelDisplayAttributes="modelDisplayAttributes" :modelDisplayTitle="modelDisplayTitle" :modelPlural="modelPlural" :modelState="state" :models="bindData(state)" :admin="admin"></ModelCard>
      </div>
      <div class="container" v-if="admin && view === 'list'">
        <ModelList :modelDisplayTitle="modelDisplayTitle" :modelPlural="modelPlural" :modelState="state" :models="bindData(state)" :admin="admin"></ModelList>
      </div>
    </div>
  </div>
</template>

<script>
import { eventBus } from '../packs/models';
import ModelCard from './model_card';
import ModelList from './model_list';
import DashboardHeader from './dashboard_header';
import axios from 'axios';

export default {
  props: {
    models: {
      type: Array,
      required: true
    },
    tags: {
      type: Array,
      required: true
    },
    pendingModels: {
      type: Array
    },
    deniedModels: {
      type: Array
    },
    admin: {
      type: Boolean,
      required: true
    },
    modelSingular: {
      type: String,
      required: true
    },
    modelPlural: {
      type: String,
      required: true
    },
    modelDisplayTitle: {
      type: String,
      required: true
    },
    modelDisplayAttributes: {
      type: Object,
      required: false
    }
  },
  data: function () {
    return {
      modelStates: ['pending', 'active', 'denied'],
      tagsData: this.tags,
      activeModelsData: this.models,
      pendingModelsData: this.pendingModels,
      deniedModelsData: this.deniedModels,
      view: 'card'
    }
  },
  methods: {
    toggleView: function () {
      this.view = this.view === 'card' ? 'list' : 'card';
    },
    bindData: function(state) {
      return this[`${state}ModelsData`];
    }
  },
  created: function () {
    eventBus.$on(`active_${this.modelPlural}_updated`, models => {
      this.activeModelsData = models;
    });
  },
  components: {
    ModelCard,
    ModelList,
    DashboardHeader
  }
}
</script>
