<template>
  <div class="models-dashboard">
    <DashboardHeader :model="modelPlural" :tags="tagsData"></DashboardHeader>
    <nav class="subnav">
      <a class="btn btn-primary" v-if="admin || modelSingular === 'activity'" v-bind:title="`Add a new ${modelSingular}`" v-bind:href="`/${modelPlural}/new`">Add {{ modelSingular }}</a>
      <button v-on:click="toggleView" title="Toggle view" class="btn btn-primary">View as {{ view === 'card' ? 'list' : 'cards' }}</button>
    </nav>
    <div class="container" v-if="admin && view === 'card'">
      <ModelCard :modelDisplayAttributes="modelDisplayAttributes" :modelDisplayTitle="modelDisplayTitle" :modelPlural="modelPlural" modelState="pending" :models="pendingModelsData" :admin="admin"></ModelCard>
    </div>
    <div class="container" v-if="admin && view === 'list'">
      <ModelList :modelDisplayTitle="modelDisplayTitle" :modelPlural="modelPlural" modelState="pending" :models="pendingModelsData" :admin="admin"></ModelList>
    </div>
    <div class="container" v-if="view === 'card'">
      <ModelCard :modelDisplayAttributes="modelDisplayAttributes" :modelDisplayTitle="modelDisplayTitle" :modelPlural="modelPlural" modelState="active" :models="modelsData" :admin="admin"></ModelCard>
    </div>
    <div class="container" v-if="view === 'list'">
      <ModelList :modelDisplayTitle="modelDisplayTitle" :modelPlural="modelPlural" modelState="active" :models="modelsData" :admin="admin"></ModelList>
    </div>
    <div class="container" v-if="admin && view === 'card'">
      <ModelCard :modelDisplayAttributes="modelDisplayAttributes" :modelDisplayTitle="modelDisplayTitle" :modelPlural="modelPlural" modelState="denied" :models="deniedModelsData" :admin="admin"></ModelCard>
    </div>
    <div class="container" v-if="admin && view === 'list'">
      <ModelList :modelDisplayTitle="modelDisplayTitle" :modelPlural="modelPlural" modelState="denied" :models="deniedModelsData" :admin="admin"></ModelList>
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
      tagsData: this.tags,
      modelsData: this.models,
      pendingModelsData: this.pendingModels,
      deniedModelsData: this.deniedModels,
      view: 'card'
    }
  },
  methods: {
    toggleView: function () {
      this.view = this.view === 'card' ? 'list' : 'card';
    }
  },
  created: function () {
    eventBus.$on(`active_${this.modelPlural}_updated`, models => {
      this.modelsData = models;
    });
  },
  components: {
    ModelCard,
    ModelList,
    DashboardHeader
  }
}
</script>
