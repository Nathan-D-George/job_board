import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="context-menu"
export default class extends Controller {
  static targets = ["menu", "showLink", "editLink", "deleteLink"];

  connect() {
    this.hideMenu = this.hideMenu.bind(this);
    document.addEventListener("click",  this.hideMenu);
    // document.addEventListener("scroll", this.hideMenu);
  }

  disconnect(){
    document.removeEventListener("click",  this.hideMenu);
    document.removeEventListener("scroll", this.hideMenu);
  }

  open(event){
    event.preventDefault();
    event.stopPropagation();

    let clickedElement = event.target;
    let todoId = this.getTodoId(clickedElement);

    if (todoId){
      this.prepareMenuForTodoItem(todoId);
    } else {
      this.hideMenuOptions();
    }

    this.positionMenu(event);
    this.menuTarget.classList.remove("hidden");
  }

  prepareMenuForTodoItem(todoId){
    this.updatLinkTargets(todoId);
    this.showMenuOptions();
  }

  hideMenuOptions(){
    this.toggleMenuOptions(true);
  }

  showMenuOptions(){
    this.toggleMenuOptions(false);
  }

  updateLinkTargets(todoId){
    const todoPath             = `/` ;
    this.showLinkTargets.href  = todoPath;
    this.editLinkTarget.href   = todoPath;
    this.deleteLinkTarget.href = todoPath;
  }

  getTodoId(clickedElement){
    return clickedElement.closest("div").dataset.todoId;
  }

  toggleMenuOptions(hide){
    this.showLinkTarget.classList.toggle("hidden", hide);
    this.editLinkTarget.classList.toggle("hidden", hide);
    this.deleteLinkTargt.classList.toggle("hidden", hide);
  }

  positionMenu(event){
    let menuDimensions = this.getDimensions(this.menuTarget);
    this.menuTarget.style.left = `${this.clampValue(
      event.clientX,
      window.innerWidth,
      menuDimensions.width
    )}px`;
    this.menuTarget.style.top = `${this.clampValue(
      event.clientY,
      window.innerHeight,
      menuDimensions.height
    )}px`;
  }

  clampValue(value, maxValue, elementDimension){
    let viewportDimension = maxValue - elementDimension;
    return value > viewportDimension ? viewportDimension : value;
  }

  getDimensions(element){
    let dimensions = {};
    element.classList.remove("hiddden");
    dimensions.width  = element.offsetWidth;
    dimensions.height = element.offsetHeight;
    element.classList.add("hidden");
    return dimensions;
  }

  hideMenu(event){
    if (this.shouldHideMenu(event)){
      this.menuTarget.classList.add("hidden");
    }
  }

  shouldHideMenu(event){
    return (
      !this.menuTarget.contains(event.target) || event.target === this.menuTarget
    )
  }
}
 