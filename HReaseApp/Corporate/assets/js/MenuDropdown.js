const
    body = document.querySelector('body'),
    section = document.querySelector('section'),
    sidebar = body.querySelector('nav'),

    CompAdmin = body.querySelector(".CompanyAdmin"),
    EmpAdmin = body.querySelector(".EmployeeAdmin"),
    TimeClock = body.querySelector(".TimeClock"),
    Schedule = body.querySelector(".Schedule"),

    sub1 = body.querySelector(".sub1"),
    sub2 = body.querySelector(".sub2"),
    sub3 = body.querySelector(".sub3"),
    sub4 = body.querySelector(".sub4"),


    toggle = body.querySelector(".toggle"),
    toggle1 = body.querySelector(".toggle1"),
    toggle2 = body.querySelector(".toggle2"),
    toggle3 = body.querySelector(".toggle3"),
    toggle4 = body.querySelector(".toggle4"),
    searchBtn = body.querySelector(".search-box"),
    modeSwitch = body.querySelector(".toggle-switch"),
    modeText = body.querySelector(".mode-text");


//CompAdmin.addEventListener("click", () => {
//    sub1.classList.toggle("show")
//    CompAdmin.classList.toggle("open")
//    sub2.classList.remove("show")
//    sub3.classList.remove("show")
//    sub4.classList.remove("show")
//})

//EmpAdmin.addEventListener("click", () => {
//    sub2.classList.toggle("show")
//    EmpAdmin.classList.toggle("open")
//    sub1.classList.remove("show")
//    sub3.classList.remove("show")
//    sub4.classList.remove("show")
//})
TimeClock.addEventListener("click", () => {
    sub3.classList.toggle("show")
    TimeClock.classList.toggle("open")
    sub1.classList.remove("show")
    sub2.classList.remove("show")
    sub4.classList.remove("show")
})
Schedule.addEventListener("click", () => {
    sub4.classList.toggle("show")
    Schedule.classList.toggle("open")
    sub1.classList.remove("show")
    sub2.classList.remove("show")
    sub3.classList.remove("show")
})



//toggle.addEventListener("click", () => {
//    sidebar.classList.toggle("close");
//    sub1.classList.remove("show")
//    sub2.classList.remove("show")
//    sub3.classList.remove("show")
//    sub4.classList.remove("show")
//})


//toggle1.addEventListener("click", () => {
//    sidebar.classList.toggle("close");
//    sub1.classList.toggle("show")
//    sub2.classList.remove("show")
//    sub3.classList.remove("show")
//    sub4.classList.remove("show")
//})
//toggle2.addEventListener("click", () => {
//    sidebar.classList.toggle("close");
//    sub2.classList.toggle("show")
//    sub1.classList.remove("show")
//    sub3.classList.remove("show")
//    sub4.classList.remove("show")
//})
//toggle3.addEventListener("click", () => {
//    sidebar.classList.toggle("close");
//    sub3.classList.toggle("show")
//    sub2.classList.remove("show")
//    sub1.classList.remove("show")
//    sub4.classList.remove("show")
//})
//toggle4.addEventListener("click", () => {
//    sidebar.classList.toggle("close");
//    sub4.classList.toggle("show")
//    sub2.classList.remove("show")
//    sub3.classList.remove("show")
//    sub1.classList.remove("show")
//})

searchBtn.addEventListener("click", () => {
    sidebar.classList.remove("close");

})

modeSwitch.addEventListener("click", () => {
    body.classList.toggle("dark");

    if (body.classList.contains("dark")) {
        modeText.innerText = "Light mode";
    } else {
        modeText.innerText = "Dark mode";

    }
});

modeSwitch.addEventListener("click", () => {
    section.classList.toggle("dark");


    if (section.classList.contains("dark")) {
        modeText.innerText = "Light mode";
    } else {
        modeText.innerText = "Dark mode";

    }
});

function myFunction() {
    var input, filter, ul, li, a, i, txtValue;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    ul = document.getElementById("myUL");
    li = ul.getElementsByTagName("li");
    for (i = 0; i < li.length; i++) {
        a = li[i].getElementsByTagName("a")[0];
        txtValue = a.textContent || a.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";

        } else {
            li[i].style.display = "none";
        }
    }
}
