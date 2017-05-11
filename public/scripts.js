// the below function adds a field to a form when a checkbox is clicked (cbox). To implement, just add add the following to the checkbox tags 'onClick="dynamicInput(this)"'.

function dynamicInput(cbox) {
  console.log(cbox)
  if (cbox.checked) {
    var input = document.createElement("input");
    input.type = "number";
    input.name = "quantity[]"
    var div = document.createElement("div");
    div.innerHTML = "quantity:";
    div.id = "dynamic1"
    div.appendChild(input);
    document.getElementById(cbox.value).appendChild(div);
    var input = document.createElement("input");
    input.type = "text";
    input.name = "units[]"
    var div = document.createElement("div");
    div.innerHTML = "units:";
    div.id = "dynamic2"
    div.appendChild(input);
    document.getElementById(cbox.value).appendChild(div);
  } else {
    document.getElementById("dynamic1").remove();
    document.getElementById("dynamic2").remove()
  }
}



// $(function(){
//   $(".cbox").click(function() {
//     console.log(self)
//     dynInput(self)
//   });
// });
