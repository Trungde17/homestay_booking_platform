<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Room Booking Form</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .form-container {
                margin: 50px auto;
                max-width: 600px;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #fff;
            }
            .form-container h2 {
                background-color: #d4004b;
                color: white;
                padding: 10px;
                border-radius: 8px 8px 0 0;
                margin: -20px -20px 20px -20px;
            }
            .btn-save {
                background-color: #d4004b;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="form-container">
                <form>
                    <h2>Rooms</h2>
                    <div class="form-group">
                        <label for="bedroomName">Bedroom Name*</label>
                        <input type="text" class="form-control" id="bedroomName" placeholder="Eg. Room 1 / Loft Room">
                    </div>
                    <div class="form-group">
                        <label for="beds">Beds*</label>
                        <select class="form-control" id="beds">
                            <option>Single bed</option>
                            <option>Double bed</option>
                        </select>
                        <small><a href="#" id="addAnotherBed">Add another bed</a></small>
                    </div>
                    <div class="form-group">
                        <label for="numGuests">Number of guests in this room*</label>
                        <select class="form-control" id="numGuests" onchange="togglePriceForTwo()">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                        </select>
                    </div>
                    <h4>Room Prices</h4>
                    <div class="form-group row">
                        <div class="col-sm-6">
                            <label>Price for 1 Person</label>
                            <div class="form-group">
                                <label for="nightlyPrice1">Nightly (1 night)</label>
                                <input type="text" class="form-control" id="nightlyPrice1" placeholder="VND">
                            </div>               
                        </div>
                        <div class="col-sm-6" id="priceForTwo" style="display: none;">
                            <label>Price for 2 (or more) People</label>
                            <div class="form-group">
                                <label for="nightlyPrice2">Nightly (1 night)</label>
                                <input type="text" class="form-control" id="nightlyPrice2" placeholder="VND">
                            </div>              
                        </div>
                    </div>
                    <button type="submit" class="btn btn-save">Save Details</button>
                </form>
                <a href="" class="btn btn-primary btn-lg">Continue</a>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                        function togglePriceForTwo() {
                            var numGuests = document.getElementById("numGuests").value;
                            var priceForTwo = document.getElementById("priceForTwo");
                            if (numGuests > 1) {
                                priceForTwo.style.display = "block";
                            } else {
                                priceForTwo.style.display = "none";
                            }
                        }
        </script>
    </body>
</html>
