<template>
  <div class="model-card">
    <div v-for="modelGroup in modelsData">
      <div class="row display-flex">
        <div v-for="model in modelGroup" class="col-lg-4 center">
          <div class="col-lg-12 center individual-card" v-bind:class="modelState">
            <div v-if="displayLogo" class="logo">
              <img v-bind:src="model.logo_url" v-bind:alt="model.name" />
            </div>
            <div class="info">
              <h3>
                <a v-bind:href="`/${modelPlural}/${model.id}`">{{ model[modelDisplayTitle] }}</a>
              </h3>
              <div v-if="modelDisplayAttributes">
                <div v-for="entry in Object.entries(modelDisplayAttributes)">
                  <p class="model-detail" v-if="model['ongoing'] && entry[0] == 'when_start'">Time: Ongoing</p>
                  <p class="model-detail" v-else-if="model[entry[0]]">{{ entry[1] }}: {{ format(model[entry[0]]) }}</p>
                </div>
              </div>
              <p>
                <a v-if="admin" v-bind:href="`/${modelPlural}/${model.id}/edit`">Edit</a>
              </p>
              <div class="btn btn-secondary btn-sm btn-static" v-for="tag in model.tag_list">{{ tag }}</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import _ from 'lodash';
import moment from 'moment';
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
      type: Object,
      required: false
    }
  },
  data: function () {
    return {
      modelsData: _.chunk(this.models, 3),
      displayLogo: this.modelPlural == 'organizations'
    }
  },
  methods: {
    format: function (value) {
      const formatted = moment(value);
      if (formatted._isValid) {
        return formatted.format('MMMM Do YYYY, h:mm a');
      }
      return value;
    }
  },
  created: function () {
    eventBus.$on(`${this.modelState}_${this.modelPlural}_updated`, models => {
      this.modelsData = _.chunk(models, 3)
    });
  }
}
</script>
