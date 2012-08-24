// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var Selector = {
	speed: 400,
	init: function() {
		$("*[data-selector]").each(function(index, div) {
			new Selector.object($(div))
		})
	},
	toggle: function(obj) {
		obj.$button.hasClass("selected") ? Selector.hide(obj) : Selector.show(obj)
	},
	show: function(obj) {
		obj.$button.addClass("selected");
		obj.$selector.slideDown(Selector.speed);
	},
	hide: function(obj) {
		obj.$button.removeClass("selected");
		obj.$selector.slideUp(Selector.speed);
	},
	object: function($div) {
		var obj = this;
		this.$selector = $div.find(".selector");
		this.$selector.hide();
		this.$button = $div.find($div.data("selector"));
	 	this.$button.click(function() {
	 		Selector.toggle(obj);
	 	})
	}
}

var Textholder = {
	init: function() {
		$("*[data-textholder]").each(function(index, div) {
			new Textholder.object($(div))
		})
	},
	object: function($div) {
		var obj = this;
		var aRef = $div.data("textholder").split(",");
		this.$images = $div.find(aRef[0]);
		this.$textholder = $div.find(aRef[1]);
	 	this.$images.mouseover(function() {
			obj.$textholder.html(this.title);
	 	})
	 	this.$images.mouseout(function() {
			obj.$textholder.html("");
	 	})
	}
}

$(document).ready(function() {
	Selector.init();
	Textholder.init();
});
