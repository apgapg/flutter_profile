'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "img/logo.png": "17170ed008bf66a7b7c23aece77829c6",
"main.dart.js": "884b48d627de8b087784db849f343edc",
"favicon.png": "a176c1d0cdf345450c5f997332b4e32e",
"css/styles.css": "fc8b962ee0bea645fe7b8fdd0903785b",
"manifest.json": "dd397ab10a6bff9f3ae89bb75205a932",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "4e80094f4ccf31111eb4d0e7dd0afc84",
"assets/NOTICES": "f30a83ff36abb0a9354aad44864736de",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"assets/assets/fonts/nunitoSemiBold.ttf": "713ac08dfb7141494d4a69f344ff69fd",
"assets/assets/fonts/nunitoBold.ttf": "6f47bcfc065790f02ed3cb8b51bef56f",
"assets/assets/fonts/MyIcons.ttf": "48a876a0bbdfbc1f8270e8a1e0670c4c",
"assets/assets/images/unacademy/1.png": "8735b278cb17b0d711a2af3a2ede263b",
"assets/assets/images/unacademy/2.png": "06c535416101be61071c7e20df5d8e81",
"assets/assets/images/unacademy/4.png": "ed942958730b82bec7706cf7c1952273",
"assets/assets/images/unacademy/3.png": "3da8992226591049c03696f7f18cb65f",
"assets/assets/images/artist/i5.jpg": "b66c91eedeef341b794cf04aa9c2b0f0",
"assets/assets/images/artist/i3.jpg": "970d892bca03e06cf31d6742095f7081",
"assets/assets/images/artist/i4.jpg": "a98253942ee8ec7ec47ded505396ff0f",
"assets/assets/images/artist/i2.jpg": "b3730905d9c1ab82fb400a7fcff3d961",
"assets/assets/images/artist/i1.jpg": "16ee3a057baf5db8ad0f1244ee3e6ae5",
"assets/assets/images/lucknow_heritage.png": "e94126b8793a3d3a8db8eea2bb631eb3",
"assets/assets/images/unacademy.png": "6f0f66153b7f23a26bdaae4cc4cd809f",
"assets/assets/images/mobile.png": "0a82b2e4e2b16476677afa955d696e76",
"assets/assets/images/plane_text.png": "fd76879f298b4857791db50fee08ef9b",
"assets/assets/images/avatar.png": "db28132bdd863ff7ab2a74b45b4d94ae",
"assets/assets/images/falogo.png": "9b98273e0e38d565736441866efef690",
"assets/assets/images/laptop.png": "3e1ac7e319fd13e5ceb7971e98fd9799",
"assets/assets/images/hand.png": "9227c49b01dbc32f175097daebec9b19",
"assets/assets/images/review.png": "8004ad6c3861371f9008a0e3ce3708f7",
"assets/assets/images/falogo.jpeg": "46847f46ff28a0b1455e57792fa95759",
"assets/assets/images/pen.png": "b379ac7b3a9f1cd3fe60ef2f0896e4a2",
"assets/assets/images/lucknow.png": "d6253d6182fd2a4295f6e0275af5f16b",
"assets/AssetManifest.json": "4010b2ce9927858372596aa8c1a87206",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"index.html": "09355c01cad11070e325ac60fdd7e840",
"/": "09355c01cad11070e325ac60fdd7e840"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');

      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message === 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
