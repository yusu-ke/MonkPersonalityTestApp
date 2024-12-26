// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener('turbo:load', function () {
  var swiper = new Swiper(".mySwiper", {
    spaceBetween: 30,
    effect: "fade",
    pagination: {
      el: ".swiper-pagination",
      clickable: true,
    },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
  });

  Turbo.frame.find('posts').addEventListener('turbo:frame-load', function () {
    swiper.update();  // Swiperの更新
  });
});