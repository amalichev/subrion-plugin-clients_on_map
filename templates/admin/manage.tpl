<form method="post" enctype="multipart/form-data" class="sap-form form-horizontal">
  {preventCsrf}

  <div class="wrap-list">
    <div class="wrap-group">
      <div class="wrap-group-heading">
        <h4>{lang key='options'}</h4>
      </div>

      <div class="row">
        <label class="col col-lg-2 control-label" for="input-client">{lang key='client'}</label>
        <div class="col col-lg-4">
          <input type="text" name="client" value="{if isset($item.client)}{$item.client|escape:'html'}{/if}" id="input-client">
        </div>
      </div>

      <div class="row">
        <label class="col col-lg-2 control-label" for="address">{lang key='address'}</label>
        <div class="col col-lg-8">
          {if isset($item.address)}
            {ia_wysiwyg name='address' value=$item.address}
          {else}
            {ia_wysiwyg name='address'}
          {/if}
        </div>
      </div>

      <div class="row">
        <label class="col col-lg-2 control-label" for="map">{lang key='location'}</label>
        <div class="col col-lg-8">
          <div id="map" style=" width: 100%; height: 350px"></div>

          <script src="//maps.google.com/maps/api/js?sensor=true"></script>
          <script>
            function initialize() {
              {if isset($item.lat)}var lat = {$item.lat};{else}var lat = 0;{/if}
              {if isset($item.lng)}var lng = {$item.lng};{else}var lng = 0;{/if}

              var option = {
                center: new google.maps.LatLng(lat, lng),
                zoom: 5
              };
              var map = new google.maps.Map(document.getElementById("map"), option);
              var marker = new google.maps.Marker({
                position: new google.maps.LatLng(lat, lng),
                map: map,
                draggable:true
              });
              marker.addListener('drag',function(event) {
                document.getElementById('lat').value = event.latLng.lat();
                document.getElementById('lng').value = event.latLng.lng();
              });
            }
            initialize();
          </script>
        </div>
      </div>
    </div>

    <input type="hidden" name="lat" value="{if isset($item.lat)}{$item.lat}{/if}" id="lat">
    <input type="hidden" name="lng" value="{if isset($item.lng)}{$item.lng}{/if}" id="lng">

    {include file='fields-system.tpl' noSystemFields=true}
  </div>
</form>
