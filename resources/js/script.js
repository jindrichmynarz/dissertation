var addHeadingAnchors = function () {
  var selector = [1, 2, 3, 4, 5, 6].map(function (idx) {
        return "section[id] h" + idx.toString();
      }).join(","),
      sectionHeadings = Array.from(document.querySelectorAll(selector)),
      sectionHeadingsLength = sectionHeadings.length;

  for (var i = 0; i < sectionHeadingsLength; i++) {
    var heading = sectionHeadings[i],
        child = document.createElement("a");
    child.className = "anchor";
    child.title = "Link to the section";
    child.href = "#" + heading.parentNode.id;
    child.innerHTML = "&nbsp;&para;";
    heading.appendChild(child);
  }
};

(function () {
  addHeadingAnchors();
})();
