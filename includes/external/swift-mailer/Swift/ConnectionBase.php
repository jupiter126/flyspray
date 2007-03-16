<?php

/**
 * Swift Mailer Connection Base Class
 * All connection handlers extend this abstract class
 * Please read the LICENSE file
 * @author Chris Corbyn <chris@w3style.co.uk>
 * @package Swift_Connection
 * @license GNU Lesser General Public License
 */

require_once dirname(__FILE__) . "/ClassLoader.php";
Swift_ClassLoader::load("Swift_Connection");

/**
 * Swift Connection Base Class
 * @package Swift_Connection
 * @author Chris Corbyn <chris@w3style.co.uk>
 */
class Swift_ConnectionBase extends Swift_Connection /*abstract*/
{
	/**
	 * Any extensions the server might support
	 * @var array
	 */
	var $extensions = array();
	
	/**
	 * Set an extension which the connection reports to support
	 * @param string Extension name
	 * @param array Attributes of the extension
	 */
	function setExtension($name, $options=array())
	{
		$this->extensions[$name] = $options;
	}
	/**
	 * Check if a given extension has been set as available
	 * @param string The name of the extension
	 * @return boolean
	 */
	function hasExtension($name)
	{
		return array_key_exists($name, $this->extensions);
	}
	/**
	 * Execute any needed logic after connecting and handshaking
	 */
	function postConnect(/*Swift*/ $instance) {}
	/**
	 * Get the list of attributes supported by the given extension
	 * @param string The name of the connection
	 * @return array The list of attributes
	 * @throws Swift_Connection_Exception If the extension cannot be found
	 */
	function getAttributes($extension)
	{
		if ($this->hasExtension($extension))
		{
			return $this->extensions[$extension];
		}
		else trigger_error("Unable to locate any attributes for the extension '" . $extension . "' since the extension cannot be found. " .
			"Consider using hasExtension() to check.");
	}
}
