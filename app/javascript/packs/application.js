import $ from 'jquery';

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap-sass/assets/javascripts/bootstrap';

window.$ = $;
window.jQuery = $;

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import("src/books")
import("src/users")
