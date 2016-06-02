<?php

if (iaView::REQUEST_HTML == $iaView->getRequestType())
{
	if ($iaView->blockExists('clients_on_map'))
	{
		$stmt = '`status` = :status AND `lang` = :language';
		$iaDb->bind($stmt, array('status' => iaCore::STATUS_ACTIVE, 'language' => $iaView->language));

		$sql =
			'SELECT SQL_CALC_FOUND_ROWS '.
			'g.`id`, g.`client`, g.`address`, g.`lat`, g.`lng`'.
			'FROM `:prefix:table_gmap` g '.
			'WHERE g.' . $stmt;

		$sql = iaDb::printf($sql, array(
			'prefix' => $iaDb->prefix,
			'table_gmap' => 'clients_on_map',
			'status' => iaCore::STATUS_ACTIVE,
			'language' => $iaView->language
		));
		$data = $iaDb->getAll($sql);

		$iaView->assign('clients_on_map', $data);
	}
}