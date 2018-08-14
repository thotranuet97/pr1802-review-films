$(document).on("turbolinks:load", function() {
    $(".film-slider .owl-carousel").owlCarousel({
        loop:true,
        margin:0,
        nav:false,
        dots:false,
        autoplay:true,
        autoplayTimeout:3000,
        autoplayHoverPause:true,
        responsive:{
            0:{
                items:1
            },
            600:{
                items:3
            },
            1000:{
                items:5
            }
        }
    });
    $(".navbar-toggle a").click(function(e){
        $("#canvas-sidebar").toggleClass("canvas-active");
        e.stopPropagation();
    });
    $("#canvas-sidebar").click(function(e){
        e.stopPropagation();
    });
    $(document).click(function(){
        $("#canvas-sidebar").removeClass("canvas-active");
    });
    $(".close-canvas a").click(function(){
        $("#canvas-sidebar").removeClass("canvas-active");
    });
    $(".parent-menu").click(function(){
        $(this).next().next().toggle("0");
        $(this).next().toggleClass("fa-angle-down fa-angle-right");
    });
});
