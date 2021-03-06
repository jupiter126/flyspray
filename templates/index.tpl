<?php if(isset($update_error)): ?>
<div id="updatemsg">
	<span class="bad"> {L('updatewrong')}</span>
	<a href="?hideupdatemsg=yep">{L('hidemessage')}</a>
</div>
<?php endif; ?>

<?php if (isset($updatemsg)): ?>
<div id="updatemsg">
    <a href="http://flyspray.org/">{L('updatefs')}</a> {L('currentversion')}
    <span class="bad">{$fs->version}</span> {L('latestversion')} <span class="good">{$_SESSION['latest_version']}</span>.
    <a href="?hideupdatemsg=yep">{L('hidemessage')}</a>
</div>
<?php endif; ?>

<?php if (!($user->isAnon() && count($fs->projects) == 0)): ?>
<div id="search">
  <map id="projectsearchform" name="projectsearchform">
    <form action="{$this->relativeUrl($baseurl)}index.php" method="get">
      <div>
        <button id="searchthisproject" type="submit">{L('searchthisproject')}</button>
        <input class="text" id="searchtext" name="string" type="text" size="20"
               maxlength="100" value="{Get::val('string')}" accesskey="q" />

        <input type="hidden" name="project" value="{Get::num('project', $proj->id)}" />
        <?php if (!$user->isAnon()): ?>
        <span class="save_search"><label for="save_search" id="lblsaveas">{L('saveas')}</label>
        <input class="text" type="text" value="{Get::val('search_name')}" id="save_search" name="search_name" size="15" />
        &nbsp;<button onclick="savesearch('{!Filters::escapeqs($_SERVER['QUERY_STRING'])}', '{#L('saving')}')" type="button">{L('OK')}</button>
        </span>
        <?php endif; ?>

        <span id="searchstate" style="cursor:pointer">
        <a onclick="toggleSearchBox('{#$this->themeUrl()}');return false;" href="{$this->url(array('proj' . $proj->id), array_merge($_GET, array('toggleadvanced' => 1)))}"><span id="advancedsearchstate" class="showstate">
        <img id="advancedsearchstateimg" src="<?php echo (Cookie::val('advancedsearch')) ? $this->get_image('edit_remove') : $this->get_image('edit_add'); ?>"
             alt="<?php echo (Cookie::val('advancedsearch')) ? '-' : '+'; ?>" width="16" height="16" />
        </span>{L('advanced')}</a>
        </span>

        <div id="sc2" class="switchcontent" <?php if (!Cookie::val('advancedsearch')):?>style="display:none;"<?php endif; ?> >
        <fieldset><legend>{L('miscellaneous')}</legend>
        {!tpl_checkbox('search_in_comments', Get::has('search_in_comments'), 'sic')}
        <label class="left" for="sic">{L('searchcomments')}</label>

        {!tpl_checkbox('search_in_details', Get::has('search_in_details'), 'search_in_details')}
        <label class="left" for="search_in_details">{L('searchindetails')}</label>

        {!tpl_checkbox('search_for_all', Get::has('search_for_all'), 'sfa')}
        <label class="left" for="sfa">{L('searchforall')}</label>

        {!tpl_checkbox('only_watched', Get::has('only_watched'), 'only_watched')}
        <label class="left" for="only_watched">{L('taskswatched')}</label>

        {!tpl_checkbox('only_primary', Get::has('only_primary'), 'only_primary')}
        <label class="left" for="only_primary">{L('onlyprimary')}</label>

        {!tpl_checkbox('has_attachment', Get::has('has_attachment'), 'has_attachment')}
        <label class="left" for="has_attachment">{L('hasattachment')}</label>

        </fieldset>

        <fieldset><legend>{L('taskproperties')}</legend>

        <?php if (!$proj->id): ?>
        <div class="search_select">
        <label class="default multisel" for="search_project">{L('project')}</label>
        <select name="search_project[]" id="search_project" multiple="multiple" size="5">
          {!tpl_options(array_merge(array('' => L('allprojects')), $fs->projects), Get::val('search_project', ''))}
        </select>
        </div>
        <?php endif; ?>

        <?php foreach ($proj->fields as $field): ?>
        <?php if ($field->prefs['field_type'] != FIELD_LIST) continue; ?>
        <div class="search_select">
        <label class="default multisel" for="field{$field->id}">{$field->prefs['field_name']}</label>
        {!$field->edit(!USE_DEFAULT, !LOCK_FIELD, array(), array('' => L('allitems')), array('multiple' => 'multiple', 'size' => 5))}
        </div>
        <?php endforeach; ?>

        <div class="search_select">
        <label class="default multisel" for="state">{L('state')}</label>
        <select name="status[]" id="state" multiple="multiple" size="2">
          {!tpl_options(array('open' => L('allopentasks')) +
                        array('closed' => L('allclosedtasks')),
                        Get::val('status', 'open'))}
        </select>
        </div>

        <div class="search_select">
        <label class="default multisel" for="percent">{L('percentcomplete')}</label>
        <select name="percent[]" id="percent" multiple="multiple" size="5">
          <?php $percentages = array(); for ($i = 0; $i <= 100; $i += 10) $percentages[$i] = $i; ?>
          {!tpl_options(array('' => L('anyprogress')) + $percentages, Get::val('percent', ''))}
        </select>
        </div>
        <div class="clear"></div>

        <?php foreach ($proj->fields as $field): ?>
        <?php if ($field->prefs['field_type'] != FIELD_TEXT) continue; ?>
        <div class="search_select">
        <label class="default" for="field{$field->id}">{$field->prefs['field_name']}</label>
        {!$field->edit(!USE_DEFAULT, !LOCK_FIELD)}
        </div>
        <?php endforeach; ?>

        </fieldset>

        <fieldset><legend>{L('users')}</legend>
        <label class="default multisel" for="opened">{L('openedby')}</label>
        {!tpl_userselect('opened', Get::val('opened'), 'opened')}

        <label class="default multisel" for="dev">{L('assignedto')}</label>
        {!tpl_userselect('dev', Get::val('dev'), 'dev')}

        <label class="default multisel" for="closed">{L('closedby')}</label>
        {!tpl_userselect('closed', Get::val('closed'), 'closed')}

        <?php foreach ($proj->fields as $field): ?>
        <?php if ($field->prefs['field_type'] != FIELD_USER) continue; ?>
        <label class="default multisel" for="field{$field->id}">{$field->prefs['field_name']}</label>
        {!$field->edit(!USE_DEFAULT, !LOCK_FIELD)}
        <?php endforeach; ?>

        </fieldset>

        <fieldset><legend>{L('dates')}</legend>
        <?php foreach ($proj->fields as $field): ?>
        <?php if ($field->prefs['field_type'] != FIELD_DATE) continue; ?>
        <div class="dateselect">
          {!tpl_datepicker('field' . $field->id . 'from', $field->prefs['field_name'] . ' ' . L('from'))}
          {!tpl_datepicker('field' . $field->id . 'to', L('to'))}
        </div>
        <?php endforeach; ?>

        <div class="dateselect">
          {!tpl_datepicker('changedfrom', L('selectsincedatefrom'))}
          {!tpl_datepicker('changedto', L('selectsincedateto'))}
        </div>

        <div class="dateselect">
          {!tpl_datepicker('openedfrom', L('selectopenedfrom'))}
          {!tpl_datepicker('openedto', L('selectopenedto'))}
        </div>

        <div class="dateselect">
          {!tpl_datepicker('closedfrom', L('selectclosedfrom'))}
          {!tpl_datepicker('closedto', L('selectclosedto'))}
        </div>
        </fieldset>

       </div>
       <input type="hidden" name="do" value="index" />
      </div>
    </form>
  </map>
</div>
<?php endif; ?>

<div id="tasklist">
  <form action="{$this->url(array('index', 'proj' . $proj->id))}" id="massops" method="post">
    <div>
      <?php if (count($tasks)): ?>
      <table id="tasklist_table">
        <thead>
          <tr>
            <th class="caret">
              <a href="javascript:toggleAllExpand()">
              <img style="position:absolute;" alt="{L('toggleexpansion')}" title="{L('toggleexpansion')}" src="{$this->get_image('plusminus')}" width="11" height="16" />
              </a>
            </th>
            <?php if (!$user->isAnon()): ?>
            <th class="ttcolumn">
                <?php if (!$user->isAnon() && $total): ?>
                <a href="javascript:ToggleSelected('massops')">
                  <img alt="{L('toggleselected')}" title="{L('toggleselected')}" src="{$this->get_image('kaboodleloop')}" width="16" height="16" />
                </a>
                <?php endif; ?>
            </th>
            <?php endif; ?>
            <?php foreach ($visible as $col): ?>
            {!tpl_list_heading($col, (isset($proj->fields[$col]) ? $proj->fields[$col]->prefs['field_name'] : L($col)))}
            <?php endforeach; ?>
          </tr>
        </thead>
        <tbody>
        <?php foreach ($tasks as $task):?>
        <tr id="task{!$task['task_id']}" class="task {$fs->GetColorCssClass($task)}">
          <td class="caret plus" onclick="toggleExpand('{$task['task_id']}', this);">
          </td>
          <?php if (!$user->isAnon()): ?>
          <td class="ttcolumn">
            <input class="ticktask" type="checkbox" name="ids[]" value="{$task['task_id']}" />
          </td>
          <?php endif; ?>
          <?php foreach ($visible as $col): ?>
          {!tpl_draw_cell($task, $col)}
          <?php endforeach; ?>
        </tr>
        <tr class="expandedinfo hide" id="expa{$task['task_id']}">
          <td colspan="2"></td>
          <td colspan="{count($visible)}">{!nl2br(Filters::noXSS($task['detailed_desc']))}</td>
         </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
      <?php endif; ?>
      <table id="pagenumbers">
        <tr>
          <?php if ($total): ?>
          <td id="taskrange">
          <?php if (!$perpage) $perpage = $total; ?>
            {!sprintf(L('taskrange'), $offset + 1,
              ($offset + $perpage > $total ? $total : $offset + $perpage), $total)}
          </td>
          <td id="numbers">
            {!pagenums($pagenum, $perpage, $total)}
          </td>
          <?php else: ?>
          <td id="taskrange"><strong>{L('noresults')}</strong></td>
          <?php endif; ?>
        </tr>
        <?php if (!$user->isAnon() && $total): ?>
        <tr id="massopsactions">
          <td>
            <select name="action">
              <option value="add_notification">{L('watchtasks')}</option>
              <option value="remove_notification">{L('stopwatchingtasks')}</option>
              <option value="takeownership">{L('assigntaskstome')}</option>
              <option value="mass_edit">{L('massedit')}</option>
            </select>
            <input type="hidden" name="user_id" value="{$user->id}" />
            <button type="submit">{L('takeaction')}</button>
          </td>
          <td id="export">
            {L('export')}
            <a href="{$this->relativeUrl($baseurl)}?{http_build_query(array_merge($_GET, array('do' => 'export')))}">
              <img alt="" title="{L('csvexport')}" src="{$this->get_image('csvexport')}" width="16" height="16" /> {L('csv')}
            </a>
            <a href="{$this->relativeUrl($baseurl)}?{http_build_query(array_merge($_GET, array('do' => 'export', 'type' => 'iCal')))}">
              <img alt="" title="{L('calendarexport')}" src="{$this->get_image('x-office-calendar')}" width="16" height="16" /> {L('iCal')}
            </a>
          </td>
        </tr>
        <?php endif ?>
      </table>
    </div>
  </form>
</div>