$(document).ready(function() {
  document.getElementById("style-2").addEventListener("scroll", function(){
    var scroll = this.scrollTop - 20;
    var translate = "translate(0,"+scroll+"px)";
    this.querySelector("thead").style.transform = translate;
  });
});
