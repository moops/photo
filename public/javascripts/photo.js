function changeScreenSize(w,h) {
  self.resizeTo( w,h );
  window.resizeTo( w,h );
  if (window.innerHeight) {
    window.innerWidth = w;
    window.innerHeight = h;
  } else if (document.documentElement.clientHeight) {
    document.documentElement.clientWidth = w;
    document.documentElement.clientHeight = h;
  } else if (document.body.clientHeight) {
    document.body.clientWidth = w;
    document.body.clientHeight = h;
  }
}               