//Bridges Web App Project
//natkiypie

var tags = [];
var newTags = [];
var loginAttempt = 3;

function filterTags(tag) {
  var buttonContainer = document.getElementById("buttonContainer");
  var buttonElement = buttonContainer.getElementsByClassName(tag);
  for (var i = 0; i < buttonElement.length; i++) {
    buttonElement[i].classList.toggle("toggle");
  }
  if (tags.includes(tag)) {
    removeTags(tag);
  } else {
    addTags(tag);
  }
}

function removeTags(tag) {
  var tagIndex = tags.indexOf(tag);
  var element = document.getElementsByClassName(tag);
  if (tagIndex > -1) {
    tags.splice(tagIndex, 1);
  }
  for (var i = 0; i < element.length; i++) {
    element[i].classList.remove("show");
  }
}

function addTags(tag) {
  tags.push(tag);
  var element = document.getElementsByClassName(tag);
  for (var i = 0; i < element.length; i++) {
    element[i].classList.add("show");
  }
}

function displayResults() {
  var searchCriteria = document.getElementById("search").value;
  var listing = document.getElementsByClassName("listing");
  for (var i = 0; i < listing.length; i++) {
    if (listing[i].classList.contains("show", "showNew") || listing[i].classList.contains(searchCriteria)) {
      listing[i].style.display = "block";
    } else if (listing[i].classList.contains("show", "showNew") == false) {
      listing[i].style.display = "none";
    }
  }
  displayNewEdit();
}

function displayNewEdit() {
  var element = document.getElementsByClassName("newEdit");
  for (var i = 0; i < element.length; i++) {
    if (element[i].classList.contains("show")) {
      element[i].style.display = "block";
    } else if (element[i].classList.contains("show") == false) {
      element[i].style.display = "none";
    }
  }
}

function validateLoginCredentials(event){
  var username = document.getElementById("username").value;
  var password = document.getElementById("password").value;
  if ( username == "admin" && password == "pass"){
    loginToLogout();
    hideLogin();
    showDash();
    showEdit();
    showCreate();
    return false;
  } else {
    event.preventDefault(event);
    loginAttempt --;
    alert("You have left "+loginAttempt+" loginAttempt;");
    if( loginAttempt == 0){
      document.getElementById("username").disabled = true;
      document.getElementById("password").disabled = true;
      document.getElementById("submit").disabled = true;
      return false;
    }
  }
}

loginOnEnter();

function loginOnEnter() {
var input = document.getElementById("password");
input.addEventListener("keyup", function(event) {
    event.preventDefault();
    if (event.keyCode === 13) {
        document.getElementById("loginButton").click();
    }
});
}

function loginToLogout() {
  var element = document.getElementById("loginButton");
  if (element.value=="login") {
    element.value = "logout";
  } else {
    logout();
  }
}

function logout() {
  document.location.reload(true);
}

function hideLogin() {
  var nameElement = document.getElementById("username");
  var passElement = document.getElementById("password");
  if (nameElement.style.display === "none") {
    nameElement.style.display = "inline";
    passElement.style.display = "inline";
  } else {
    nameElement.style.display = "none";
    passElement.style.display = "none";
  }
}

function showEdit() {
  var editElement = document.getElementsByClassName("edit");
  for (var i = 0; i < editElement.length; i++) {
    editElement[i].style.display = "inline";
  }
}

function showCreate() {
  var element = document.getElementById("create");
  element.style.display = "inline";
}

function editListing(id){
  var contenteditable = document.getElementById(id).contentEditable;
  if(contenteditable == "inherit" || contenteditable == "false"){
    document.getElementById(id).contentEditable = true;
  }else{
    document.getElementById(id).contentEditable = false;
  }
}

function modalToForefront() {
  document.getElementById("create").style.zIndex = "1"; 
}

function closeModal() {
  var modal = document.getElementById('createPost');
  modal.style.display = "none";
}

function closeModalOnClick() {
  var modal = document.getElementById('createPost');
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  };
}

function createPosting(event) {
  newDiv();
  event.preventDefault(event);
  closeModal();
  resetNewTagToggle();
  clearNewTagsContainer();
}

function newDiv() {
  var orgName = document.getElementById("orgName");
  var orgNameRefined = orgName.value.replace(/\s/g, "");
  setEditAttributes(orgNameRefined);
  var userInput = document.getElementById("userInput").value;
  var newContent = document.createTextNode(userInput); 
  var newDiv = document.createElement("div"); 
  newDiv.setAttribute("id", orgNameRefined);
  newDiv.appendChild(newContent);  
  var currentDiv = document.getElementById(orgNameRefined); 
  document.body.insertBefore(newDiv, currentDiv);
  addClass(newDiv);
  newDiv.contentEditable = false;
}

function filterNewTags(tag) {
  var buttonContainer = document.getElementById("newButtonContainer");
  var buttonElement = buttonContainer.getElementsByClassName(tag);
  for (var i = 0; i < buttonElement.length; i++) {
    buttonElement[i].classList.toggle("toggle");
  }
  if (newTags.includes(tag)) {
    removeNewTags(tag);
  } else {
    addNewTags(tag);
  }
  addNewEditTag(tag);
}

function addNewEditTag(tag) {
  var element = document.getElementsByClassName("newEdit");
  for (var i = 0; i < element.length; i++) {
    if (element[i].classList.contains(tag) && element[i].hasAttribute("id") == false) {
      element[i].classList.remove(tag);
    } else if (element[i].hasAttribute("id") == false) {
      element[i].classList.add(tag);
    }
  }
}

function removeNewTags(tag) {
  var tagIndex = newTags.indexOf(tag);
  if (tagIndex > -1) {
    newTags.splice(tagIndex, 1);
  }
}

function addNewTags(tag) {
  newTags.push(tag);
}

function addClass(newDiv) {
  for(var i = 0; i < newTags.length; i++) {
    newDiv.classList.add(newTags[i]);
  }
  newDiv.classList.add("listing", "hide", "showNew");
}

function clearNewTagsContainer() {
  newTags.length = 0;
}

function resetNewTagToggle() {
  var buttonContainer = document.getElementById("newButtonContainer");
  var buttonElement = buttonContainer.getElementsByClassName("newTag");
  for (var i = 0; i < buttonElement.length; i++) {
    if (buttonElement[i].classList.contains("toggle") == false) {
      buttonElement[i].classList.add("toggle");
    }
  }
}

function createNewEditButton() {
  var button = document.createElement("button");
  var label = document.createTextNode("edit");
  button.appendChild(label);
  button.classList.add("newEdit", "hide");
  var currentDiv = document.getElementById("listingContainer"); 
  document.body.insertBefore(button, currentDiv.nextSibling);
}

function setEditAttributes(id) {
  var element = document.getElementsByClassName("newEdit");
  for (var i = 0; i < element.length; i++) {
    element[i].id = id;
    element[i].addEventListener("click", function(e) {
      editListing(id);
    });
  }
}

function showDash() {
document.getElementById("dashboard").innerHTML = "<button class='button green' type='button' onclick='toggleDash()'>dashboard</button>";
}

function toggleDash() {
  var element = document.getElementById("myDash");
  if(element.style.width == "0%") {
    element.style.width = "50%";
  } else {
    element.style.width = "0%";
  }
}
