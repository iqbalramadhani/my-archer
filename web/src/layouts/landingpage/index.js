import PropTypes from 'prop-types'
import React, { Component } from "react"
import { withRouter } from "react-router-dom"
import "toastr/build/toastr.min.css"

class LandingPageLayout extends Component {
  constructor(props) {
    super(props)
    this.state = {}
    this.capitalizeFirstLetter.bind(this)
  }

  capitalizeFirstLetter = string => {
    return string.charAt(1).toUpperCase() + string.slice(2)
  }

  render() {
    return <React.Fragment>{this.props.children}</React.Fragment>
  }
}

LandingPageLayout.propTypes = {
  children: PropTypes.any,
  location: PropTypes.object
}

export default withRouter(LandingPageLayout)
