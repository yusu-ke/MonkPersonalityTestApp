// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener('turbo:load', () => {
  const createImageHTML = (blob) => {
    const imageElement = document.getElementById('new-image');
    
    const blobImage = document.createElement('img');
    blobImage.setAttribute('class', 'new-img');
    blobImage.setAttribute('src', blob);

    imageElement.appendChild(blobImage);
  };

  document.getElementById('post_post_images').addEventListener('change', (e) => {
    const files = e.target.files;
    
    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    }
  });
});


document.addEventListener("DOMContentLoaded", () => {
  const modal = document.getElementById("modal");
  const btn = document.getElementById("btn");

  if (!localStorage.getItem("visited")) {
    modal.classList.add("modal-open");

    btn.addEventListener("click", () => {
      modal.classList.remove("modal-open");
      modal.classList.add("hidden");
    });
    
    localStorage.setItem("visited", "true")
  }
});

document.addEventListener('turbo:load', function () {
  let swiper = new Swiper(".mySwiper", {
    spaceBetween: 30,
    effect: "slide",
    slidesPerView: 1,
    autoHeight: true,
    pagination: {
      el: ".swiper-pagination",
      dynamicBullets: true,
      clickable: true,
    },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
  });

  Turbo.frame.find('posts').addEventListener('turbo:frame-load', function () {
    swiper.update();
  });
});

document.addEventListener('turbo:load', () => {
  document.getElementById("modal").style.display = "block";
  document.querySelector(".c-btn").addEventListener("click", () => {
    document.getElementById("modal").style.display = "none";
  });
});
