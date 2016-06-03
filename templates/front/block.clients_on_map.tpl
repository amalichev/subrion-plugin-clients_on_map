{if $clients_on_map}
	<div id="map" style=" width: {$core.config.clients_on_map_width}; height: {$core.config.clients_on_map_height}"></div>

	<script src="//maps.google.com/maps/api/js?sensor=true"></script>
	<script>
		function initialize() {
				var myOptions = {
					{if $clients_on_map|@count > 1}
						center: new google.maps.LatLng(0, 0),
					{else}
						center: new google.maps.LatLng({$clients_on_map[0].lat}, {$clients_on_map[0].lng}),
					{/if}
					zoom: {$core.config.clients_on_map_zoom},
					styles: {$core.config.clients_on_map_style},
					scrollwheel: false,
				};
				var map = new google.maps.Map(document.getElementById("map"), myOptions);

				var bounds = new google.maps.LatLngBounds();

				{foreach $clients_on_map as $entry}
					{if empty($entry.address)} 
						{assign var="content" value="<strong>{$entry.client}</strong>"}
					{else}
						{assign var="content" value="<strong>{$entry.client}</strong><br>{$entry.address}"}
					{/if}
					var item{$entry.id} = new google.maps.LatLng({$entry.lat}, {$entry.lng});
					var marker{$entry.id} = new google.maps.Marker({
						position: item{$entry.id},
						map: map,
						title: '{$entry.client}',
						icon: '/plugins/clients_on_map/templates/front/img/marker.png',
						info: new google.maps.InfoWindow({
							content: {json_encode($content)}
						})
					});
					bounds.extend(item{$entry.id});

					google.maps.event.addListener(marker{$entry.id}, 'click', function() {
						marker{$entry.id}.info.open(map, marker{$entry.id});
					});
				{/foreach}

				{if $clients_on_map|@count > 1}
					map.fitBounds(bounds);
				{/if}
		}
		initialize();
	</script>
{/if}