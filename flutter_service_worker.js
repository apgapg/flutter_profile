'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "f13d397d4fdfa99b17e195fdcc22d377",
"main.dart.js": "14e1320e5b4e15c923fe3f4173ce5428",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "dd397ab10a6bff9f3ae89bb75205a932",
"assets/LICENSE": "7a4d025c919cb6a756b2accee035119a",
"assets/AssetManifest.json": "e15b33afbb6a16e5236d16226067e71c",
"assets/FontManifest.json": "4e80094f4ccf31111eb4d0e7dd0afc84",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/assets/images/unacademy/4.png": "ed942958730b82bec7706cf7c1952273",
"assets/assets/images/unacademy/2.png": "06c535416101be61071c7e20df5d8e81",
"assets/assets/images/unacademy/3.png": "3da8992226591049c03696f7f18cb65f",
"assets/assets/images/unacademy/1.png": "8735b278cb17b0d711a2af3a2ede263b",
"assets/assets/images/pen.png": "b379ac7b3a9f1cd3fe60ef2f0896e4a2",
"assets/assets/images/plane_text.png": "fd76879f298b4857791db50fee08ef9b",
"assets/assets/images/hand.png": "9227c49b01dbc32f175097daebec9b19",
"assets/assets/images/avatar.png": "db28132bdd863ff7ab2a74b45b4d94ae",
"assets/assets/images/falogo.png": "9b98273e0e38d565736441866efef690",
"assets/assets/images/laptop.png": "3e1ac7e319fd13e5ceb7971e98fd9799",
"assets/assets/images/lucknow.png": "d6253d6182fd2a4295f6e0275af5f16b",
"assets/assets/images/mobile.png": "0a82b2e4e2b16476677afa955d696e76",
"assets/assets/images/lucknow_heritage.png": "e94126b8793a3d3a8db8eea2bb631eb3",
"assets/assets/images/unacademy.png": "6f0f66153b7f23a26bdaae4cc4cd809f",
"assets/assets/images/artist/i1.jpg": "16ee3a057baf5db8ad0f1244ee3e6ae5",
"assets/assets/images/artist/i2.jpg": "b3730905d9c1ab82fb400a7fcff3d961",
"assets/assets/images/artist/i3.jpg": "970d892bca03e06cf31d6742095f7081",
"assets/assets/images/artist/i4.jpg": "a98253942ee8ec7ec47ded505396ff0f",
"assets/assets/images/artist/i5.jpg": "b66c91eedeef341b794cf04aa9c2b0f0",
"assets/assets/fonts/nunitoSemiBold.ttf": "713ac08dfb7141494d4a69f344ff69fd",
"assets/assets/fonts/MyIcons.ttf": "48a876a0bbdfbc1f8270e8a1e0670c4c",
"assets/assets/fonts/nunitoBold.ttf": "6f47bcfc065790f02ed3cb8b51bef56f"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
