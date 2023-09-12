import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  initialize(){
    // this.resetScrollWithoutThreshold(posts);
  }
  connect(){
    console.log("Connected");
    const posts = document.getElementById("posts");
    posts.addEventListener("DOMContentLoaded", function(event) {
      var scrollpos = sessionStorage.getItem('scrollpos');
      if (scrollpos) {
        window.scrollTo(0, scrollpos);
        sessionStorage.removeItem('scrollpos');
      }
    });

    window.addEventListener("beforeunload", function(e){
      sessionStorage.setItem('scrollpos', window.scrollY);
    });

    // posts.addEventListener("DOWNodeInserted", this.resetScroll);
    // this.resetScrollWithoutThreshold(posts);
  }
  disconnect(){
    console.log("Disconnected");
  }

  // resetScroll(){
  //   const bottomOfScroll = posts.scrollHeight - posts.clientHeight;
  //   const upperScrollThreshold = bottomOfScroll - 50;
  //   if (posts.scrollTop > upperScrollThreshold){
  //     // this.resetScrollWithoutThreshold(posts);
  //     posts.scrollTop = posts.scrollHeight - posts.clientHeight;
  //   }
  // }
  // resetScrollWithoutThreshold(posts){
  //   posts.scrollTop = posts.scrollHeight - posts.clientHeight;
  // } 

}