<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="card mb-4">
    <div class="card-header">Room Information</div>
    <div class="card-body">
        <form>
            <div class="form-group">
                <label for="roomSelectInfo">Select Room</label>
                <select class="form-control" id="roomSelectInfo">
                    <option>Room 1</option>
                    <option>Room 2</option>
                    <option>Room 3</option>
                </select>
            </div>
            <div class="form-group">
                <label for="roomInfoDetails">Room Details</label>
                <textarea class="form-control" id="roomInfoDetails" rows="3"></textarea>
            </div>
            <div class="form-group">
                <label for="roomImageUpload">Upload Room Image</label>
                <input type="file" class="form-control-file" id="roomImageUpload">
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
    </div>
</div>
