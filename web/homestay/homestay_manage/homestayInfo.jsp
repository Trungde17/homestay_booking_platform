<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="homestayInfo">
    <div class="card mb-4">
        <div class="card-header">Toggle Homestay Status</div>
        <div class="card-body">
            <form>
                <div class="form-group">
                    <label for="homestayStatus">Status</label>
                    <select class="form-control" id="homestayStatus">
                        <option>Enable</option>
                        <option>Disable</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
            </form>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header">Toggle Room Status</div>
        <div class="card-body">
            <form>
                <div class="form-group">
                    <label for="roomStatus">Select Room</label>
                    <select class="form-control" id="roomStatus">
                        <option>Room 1</option>
                        <option>Room 2</option>
                        <option>Room 3</option>
                    </select>
                    <label for="roomState">Status</label>
                    <select class="form-control" id="roomState">
                        <option>Enable</option>
                        <option>Disable</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
            </form>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header">Change Account Number</div>
        <div class="card-body">
            <form>
                <div class="form-group">
                    <label for="accountNumber">Account Number</label>
                    <input type="text" class="form-control" id="accountNumber">
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
            </form>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header">Change Room Image</div>
        <div class="card-body">
            <form>
                <div class="form-group">
                    <label for="roomImage">Select Room</label>
                    <select class="form-control" id="roomImage">
                        <option>Room 1</option>
                        <option>Room 2</option>
                        <option>Room 3</option>
                    </select>
                    <label for="roomImageUpload">Upload Image</label>
                    <input type="file" class="form-control-file" id="roomImageUpload">
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
            </form>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header">Change Homestay Image</div>
        <div class="card-body">
            <form>
                <div class="form-group">
                    <label for="homestayImageUpload">Upload Image</label>
                    <input type="file" class="form-control-file" id="homestayImageUpload">
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
            </form>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header">Update Rules</div>
        <div class="card-body">
            <form>
                <div class="form-group">
                    <label for="rules">Enter New Rules</label>
                    <textarea class="form-control" id="rules" rows="3"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
            </form>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header">Update "About Us" Section</div>
        <div class="card-body">
            <form>
                <div class="form-group">
                    <label for="aboutUs">Enter New Content</label>
                    <textarea class="form-control" id="aboutUs" rows="3"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
            </form>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header">Delete Room</div>
        <div class="card-body">
            <form>
                <div class="form-group">
                    <label for="deleteRoom">Select Room to Delete</label>
                    <select class="form-control" id="deleteRoom">
                        <option>Room 1</option>
                        <option>Room 2</option>
                        <option>Room 3</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-danger">Delete</button>
            </form>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header">Change Homestay Address</div>
        <div class="card-body">
            <form>
                <div class="form-group">
                    <label for="homestayAddress">New Address</label>
                    <input type="text" class="form-control" id="homestayAddress">
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
            </form>
        </div>
    </div>
</div>
