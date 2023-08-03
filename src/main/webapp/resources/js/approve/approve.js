/* 결재선 모달창 열고 닫는 기능 */
const open = () => {
    document.querySelector(".modal").classList.remove("hidden");
  }

  const close = () => {
    document.querySelector(".modal").classList.add("hidden");
    $("#people-box").empty();  
/*    $("#line-box>div").remove(); // empty() -> 선택한요소의 자식요소들을 모두 삭제
    $("#refer-box>div").remove();*/
    // remove() -> 선택한 요소자체를삭제 (자식까지 다 삭제)
  }

  document.querySelector(".openBtn").addEventListener("click", open);
  document.querySelector("#close-button").addEventListener("click", close);
  document.querySelector(".bg").addEventListener("click", close);