import React from "react";
import { BrowserRouter as Router, Redirect, Switch } from "react-router-dom";
import { AuthLayout, LandingPageLayout, LayoutArcher } from "./layouts";
import { AuthenticationArcherMiddleware } from "./middlewares";
import {
  workingRoutes,
  eventRouters,
  landingpageRouters,
  archerRouters,
  routerDasboardArcher,
  certificateRoutes,
} from "./routes";

import {
  dashboardRoutes,
  clubRoutes,
  eventRegistrationRoutes,
  liveScoreRoutes,
  seriesRoutes,
  ranksRoutes,
} from "./routes";
import {
  LayoutDashboard,
  LayoutClub,
  LayoutLandingPage,
  LayoutEventRegistration,
  LayoutLiveScore,
} from "layouts/ma";

import "./assets/scss/theme.scss";
import "react-datepicker/dist/react-datepicker.css";

const App = () => {
  return (
    <React.Fragment>
      <Router>
        <Switch>
          {workingRoutes.map((route, idx) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={AuthLayout}
              component={route.component}
              key={idx}
              isAuthProtected={false}
              exact
            />
          ))}

          {eventRouters.map((route, idx) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={LayoutLandingPage}
              component={route.component}
              key={idx}
              isAuthProtected={false}
              exact
            />
          ))}

          {eventRegistrationRoutes.map((route, idx) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={LayoutEventRegistration}
              component={route.component}
              key={idx}
              isAuthProtected={true}
              exact
            />
          ))}

          {liveScoreRoutes.map((route, idx) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={LayoutLiveScore}
              component={route.component}
              key={idx}
              isAuthProtected={false}
              exact
            />
          ))}

          {ranksRoutes.map((route, idx) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={LayoutLiveScore}
              component={route.component}
              key={idx}
              isAuthProtected={false}
              exact
            />
          ))}

          {seriesRoutes.map((route, idx) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={LayoutLiveScore}
              component={route.component}
              key={idx}
              isAuthProtected={false}
              exact
            />
          ))}

          {certificateRoutes.map((route, idx) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={LandingPageLayout}
              component={route.component}
              key={idx}
              isAuthProtected={false}
              exact
            />
          ))}

          {landingpageRouters.map((route, idx) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={LayoutLandingPage}
              component={route.component}
              key={idx}
              isAuthProtected={false}
              exact
            />
          ))}

          {archerRouters.map((route, idx) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={AuthLayout}
              component={route.component}
              key={idx}
              isAuthProtected={false}
              exact
            />
          ))}

          {clubRoutes.map((route, idx) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={LayoutClub}
              component={route.component}
              key={idx}
              isAuthProtected={false}
              exact
            />
          ))}

          {dashboardRoutes.map((route) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={LayoutDashboard}
              component={route.component}
              key={route.path}
              isAuthProtected={true}
              exact
            />
          ))}

          {routerDasboardArcher.map((route, idx) => (
            <AuthenticationArcherMiddleware
              path={route.path}
              layout={LayoutArcher}
              component={route.component}
              key={idx}
              isAuthProtected={true}
              exact
            />
          ))}

          <Redirect to="/working/not-found" />
        </Switch>
      </Router>
    </React.Fragment>
  );
};

export default App;
