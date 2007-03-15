<?php
/*
    This script is the AJAX callback that performs a search
    for users, and returns them in an ordered list.
*/

define('IN_FS', true);

header('Content-type: text/html; charset=utf-8');

require_once('../../header.php');

if (!$user->can_view_userlist()) {
    exit;
}

$searchterm = '%' . reset($_POST) . '%';

// Get the list of users from the global groups above
$get_users = $db->SelectLimit('SELECT u.real_name, u.user_name
                           FROM {users} u
                          WHERE u.user_name LIKE ? OR u.real_name LIKE ?', 20, 0,
                         array($searchterm, $searchterm));

$html = '<ul class="autocomplete">';

while ($row = $get_users->FetchRow())
{
   $data = array_map(array('Filters','noXSS'), $row);

   $html .= '<li title="' . $data['real_name'] . '">' . $data['user_name'] . '<span class="informal"> (' . $data['real_name'] . ')</span></li>';
}

$html .= '</ul>';

echo $html;

?>
