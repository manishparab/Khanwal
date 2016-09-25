$(function () {
    var validationControls = $('[custom-validate]');
    validationControls.each(function () {
        $(this).blur(function () {
            validateControl($(this));
        });
    });
    
    var select2Controls = $()

});

function Customvalidation() {
    var requiredControls = $('[custom-validate]');
    var validated = true;
    var tempvalidated = true;
    requiredControls.each(function () {
        tempvalidated = validateControl($(this));
        validated = validated && tempvalidated;
    });

    if (validated) {
        return true;
    } else {
        return false;
    }

}

function validateControl(obj) {
    var validated = false;
    if (obj.attr("custom-required") == "true") {

        if (obj.val().length == 0) {
            obj.closest('.control-group').removeClass('success');
            obj.closest('.control-group').addClass('error');
            obj.parent().find('label').css("display", "block");
            obj.parent().find('label').removeClass("valid");
            obj.parent().find('label').text("This field is required");
        } else {
            validated = true;
            obj.closest('.control-group').removeClass('error');
            obj.closest('.control-group').addClass('success');
            obj.parent().find('label').removeAttr("style");
            obj.parent().find('label').addClass("valid");
        }

    }

    if (validated) {
        if (obj.attr("custom-minlength")) {
            if (obj.val().length < obj.attr("custom-minlength")) {
                obj.closest('.control-group').removeClass('success');
                obj.closest('.control-group').addClass('error');
                obj.parent().find('label').css("display", "block");
                obj.parent().find('label').removeClass("valid");
                obj.parent().find('label').text("Atleast " + obj.attr("custom-minlength") + " characters are required");
            } else {
                validated = true;
                obj.closest('.control-group').removeClass('error');
                obj.closest('.control-group').addClass('success');
                obj.parent().find('label').removeAttr("style");
                obj.parent().find('label').addClass("valid");
            }


        }
    }

    return validated;

}