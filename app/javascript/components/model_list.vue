<template>
  <div class="model-list">
    <div v-for="model in modelsData">
      <div class="row p-2 individual-row" v-bind:class="modelState" v-on:click="select(model.id)">
        <div class="col align-column">
          <p>{{ model[modelDisplayTitle] }}</p>
        </div>
        <div class="col align-column">
          <span class="tag badge badge-pill mr-1" v-for="tag in model.tag_list">{{ tag }}</span>
        </div>
        <div class="col-1 align-column center-column" v-if="admin">
          <a v-on:click.stop="edit(model.id)" href="#" onclick="return false;">edit</a>
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
    },
    edit: function (id) {
      window.location.href = `/${this.modelPlural}/${id}/edit`
    }
  },
  watch: {
    models(newValue) {
      this.modelsData = newValue;
    }
  }
}
</script>
