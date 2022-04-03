import $ from 'jquery';

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
window.$ = $;
window.jQuery = $;

Rails.start()
Turbolinks.start()
ActiveStorage.start()
import 'bootstrap-sass/assets/javascripts/bootstrap';
