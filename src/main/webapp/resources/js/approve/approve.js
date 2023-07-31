/* 결재선 모달창 열고 닫는 기능 */
const open = () => {
    document.querySelector(".modal").classList.remove("hidden");
  }

  const close = () => {
    document.querySelector(".modal").classList.add("hidden");
  }

  document.querySelector(".openBtn").addEventListener("click", open);
  document.querySelector("#close-button").addEventListener("click", close);
  document.querySelector(".bg").addEventListener("click", close);