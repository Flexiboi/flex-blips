var $bliplist = '';
window.addEventListener('message', function(event) {
    const data = event.data;
    if (data.type == 'setup'){
        $("#container").fadeIn(350);
        $.each(data.list, function (index, value) {
            $bliplist += "<div class='name' id=" + value + ">" + value + "</div>";
            var state = localStorage.getItem(value);
            if (state == 'true') {
                $bliplist += "<div class='toggle normal'><input id='normal' class='" + value + "' type='checkbox' checked/><label class='toggle-item' id='" + value + "'></label></div>"
            } else if (state == 'false') {
                removeblip(value)
                $bliplist += "<div class='toggle normal'><input id='normal' class='" + value + "' type='checkbox'/><label class='toggle-item' id='" + value + "'></label></div>"
            } else {
                $bliplist += "<div class='toggle normal'><input id='normal' class='" + value + "' type='checkbox' checked/><label class='toggle-item' id='" + value + "'></label></div>"
            }
        });
        document.querySelector('#toggles').innerHTML = $bliplist;
    } else {
        $.each(data.list, function (index, value) {
            var state = localStorage.getItem(value);
            if (state == 'true') {
            } else {
                removeblip(value)
            }
        });
    }
});

$( function() {
    $("body").on("keydown", function (key) {
        if (key.keyCode == 27) {
            close();
        }
    });
});

function removeblip(blipid) {
    $.post("https://blips/ToggleBlips", JSON.stringify({
        name: blipid,
        type: 'remove'
    }));
}

function close() {
    $("#container").fadeOut(350);
    $bliplist = '';
    $.post("https://blips/CloseNui", JSON.stringify({}));
}

$(document).on('click', '.toggle-item', function(e){
    e.preventDefault();
    check = $('.' + e.target.id).is(":checked");
    if (check) {
        $('.' + e.target.id).removeAttr('checked');
        localStorage.setItem(e.target.id, 'false');
        var state = localStorage.getItem(e.target.id);
        $.post("https://blips/ToggleBlips", JSON.stringify({
            name: e.target.id,
            type: 'remove'
        }));
    } else {
        $('.' + e.target.id).attr ( "checked" ,"checked" );
        localStorage.setItem(e.target.id, 'true');
        var state = localStorage.getItem(e.target.id);
        $.post("https://blips/ToggleBlips", JSON.stringify({
            name: e.target.id,
            type: 'create'
        }));
    }
});