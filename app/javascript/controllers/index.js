// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CarouselController from "./carousel_controller"
application.register("carousel", CarouselController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import PopoverController from "./popover_controller"
application.register("popover", PopoverController)

import SwiperController from "./swiper_controller"
application.register("swiper", SwiperController)
