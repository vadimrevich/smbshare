/**********************************************************
 * alert.pwned.js
 * JavaScript XSS payload for Example
***********************************************************/

function alert_pwned() {
    var message;
    message = "Pwned!";
    alert(message);
}

alert_pwned();
