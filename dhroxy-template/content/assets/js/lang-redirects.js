// Override fhir2.base.template#0.1.0: its early return prevents language fallback.
doRedirect();

function doRedirect() {
  if (!Array.isArray(langs) || langs.length === 0) return;

  var userLang = (navigator.language || navigator.userLanguage || "").toLowerCase();
  var language = langs[0];
  for (var i = 0; i < langs.length; i++) {
    var candidate = langs[i].toLowerCase();
    if (userLang === candidate || userLang.startsWith(candidate + "-")) {
      language = langs[i];
      break;
    }
  }

  var path = window.location.pathname;
  var pageName = path.substring(path.lastIndexOf("/") + 1) || "index.html";
  window.location.replace(language + "/" + pageName + window.location.search + window.location.hash);
}
