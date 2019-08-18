<template>
  <div class="model-list">
    <div v-for="model in modelsData">
      <div class="row p-2 individual-row" v-bind:class="modelState" v-on:click="select(model.id)">
        <div class="col">
          <p>{{ model[modelDisplayTitle] }}</p>
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
import moment from 'moment';
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
    }
  },
  data: function () {
    return {
      modelsData: this.models
    }
  },
  methods: {
    select: function (id) {
      window.location.href = `/${this.modelPlural}/${id}`;
    }
  },
  watch: {
    models(newValue) {
      this.modelsData = newValue;
    }
  }
}
</script>
