'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "9bce13da5a42409a95e76305886f28a5",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "a94bef2acfc23f95b58ddbd90ebe7e3e",
"assets/fonts/Email.ttf": "ea9714218b2c1869dbf5fe8b816216dd",
"assets/fonts/BalsamiqSansRegular.ttf": "d0e0c9d174a9cec8f1383ebd7bf51b31",
"assets/fonts/Github.ttf": "7380d87a74b038db137a826e9d9be480",
"assets/fonts/ShadowsIntoLightRegular.ttf": "47c22e0adf5e3659bb254daabc61392f",
"assets/fonts/PacificoRegular.ttf": "9b94499ccea3bd82b24cb210733c4b5e",
"assets/fonts/Product-Sans-Regular.ttf": "eae9c18cee82a8a1a52e654911f8fe83",
"assets/fonts/Facebook.ttf": "4196a6a6494529878048add86ac3178d",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/fonts/MonofurforPowerline.ttf": "193fac0b96b146838f0349fa7160402a",
"assets/fonts/Product-Sans-Italic.ttf": "e88ec18827526928e71407a24937825a",
"assets/fonts/BalsamiqSansBold.ttf": "ed3ff13e6453434370d0d0a9f4ebc734",
"assets/fonts/Product-Sans-Bold.ttf": "dba0c688b8d5ee09a1e214aebd5d25e4",
"assets/fonts/Twitter.ttf": "22b0e739688d4f8ed98295876c8a3e9c",
"assets/fonts/HackedKerX.ttf": "2f48abc8c45de9add264c5be432e878e",
"assets/fonts/Construction.ttf": "73fd11d2e6b59160f4ca9b93f41715bc",
"assets/fonts/VT323Regular.ttf": "692c37377cd1e0f4850f47c7c0148426",
"assets/fonts/MyFlutterApp.ttf": "13f9bc1a047474e01e4aa5a3ce300045",
"assets/fonts/MRROBOT.ttf": "ecf427f7510fa5366337cefeeeb727d2",
"assets/fonts/BalsamiqSansItalic.ttf": "99e0b3470cea314fa44425673c4f463f",
"assets/fonts/BalsamiqSansBoldItalic.ttf": "f9176db3a423b5c5122b8609d2c28105",
"assets/FontManifest.json": "0b9ad2be56d8878fa21dcaaa920b8cec",
"assets/NOTICES": "49d8559e8d73bc11bd40b13d7e090109",
"assets/images/const_pict.png": "d8a71ff749764d43dce88918ec594a79",
"assets/images/home.jpg": "bc5cc8f0ae2f02e7e5569175e7d3e446",
"assets/images/networkError.png": "a67e6a898a75b887abb657bdf41c9da9",
"assets/images/ui.png": "0aa68b0642de2aac199995f7072d8f76",
"assets/images/bulb_on.png": "b4393f19b13e22ccbbfc02a66ee880d6",
"assets/images/bulb_off.png": "127f448df4b8c9b5d70b58b759f0794d",
"assets/packages/flutter_markdown/assets/logo.png": "67642a0b80f3d50277c44cde8f450e50",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/open_iconic_flutter/assets/open-iconic.woff": "3cf97837524dd7445e9d1462e3c4afe2",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"assets/AssetManifest.json": "7874a4f16e7e609fb2681dca5eb39181",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"index.html": "08ff53dea09537273fb6e6aa762fabfe",
"/": "08ff53dea09537273fb6e6aa762fabfe"
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
  // If the URL is not the the RESOURCE list, skip the cache.
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
  if (event.message == 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message = 'downloadOffline') {
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
