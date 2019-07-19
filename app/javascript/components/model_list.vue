<template>
  <div class="model-list">
    <div v-for="model in modelsData">
      <div class="row p-2" v-bind:class="modelState">
        <div class="col">
          <a v-bind:href="`/${modelPlural}/${model.id}`">{{ model[modelDisplayTitle] }}</a>
        </div>
        <div v-if="modelDisplayAttributes" v-for="attribute in modelDisplayAttributes">
          <div class="col">{{ attribute }}: {{ model[`${attribute}`] }}</div>
        </div>
        <div class="col">
          <div class="btn btn-secondary btn-sm btn-static" v-for="tag in model.tag_list">{{ tag }}</div>
        </div>
        <div class="col-1" v-if="admin">
          <p><a v-bind:href="`/${modelPlural}/${model.id}/edit`">Edit</a></p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import _ from 'lodash';
import { eventBus } from '../packs/models';
export default {
  props: {
    models: {
      type: Array
    },
    modelState: {
      type: String,
      validator: (state) => ['pending', 'active', 'denied'].includes(state)
    },
    admin: {
      type: Boolean,
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
      type: Array,
      required: false
    }
  },
  data: function () {
    return {
      modelsData: this.models
    }
  },
  created: function () {
    eventBus.$on(`${this.modelState}_${this.modelPlural}_updated`, models => {
      this.modelsData = models
    });
  }
}
</script>
